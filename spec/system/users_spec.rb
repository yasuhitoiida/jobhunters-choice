require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:password) { '12345678' }
  describe '新規登録' do
    before { visit '/register' }
    it '新規登録ページで各フォームに入力し「登録」を押すとユーザーが登録されている' do
      user = build(:user)
      within "#register-form" do
        fill_in 'ユーザー名', with: user.name
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: password
        fill_in 'パスワード（確認）', with: password
        click_on '登録'
      end
      expect(page).to have_current_path('/login'), 'ログインページに遷移できていません'
      expect(User.last.name).to eq user.name
    end

    it '入力内容に不備があった場合エラーメッセージが表示されている' do
      within "#register-form" do
        click_on '登録'
      end
      expect(page).to have_css('li.error-message'), 'エラーメッセージが表示されていません'
    end
  end

  describe 'ログイン' do
    let!(:user) { create(:user) }
    it '未ログイン状態でマイページにアクセスしようとするとログインページに遷移する' do
      visit '/mypage'
      expect(page).to have_current_path('/login'), 'ログインページに遷移していません'
    end

    it 'ログイン状態によってヘッダーの表示が変わる' do
      visit '/'
      expect(page).to have_content('ログイン')
      visit '/login'
      within "#login-form" do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: password
        click_on 'ログイン'
      end
      expect(page).to have_content(user.name), 'ヘッダーの表示が変わっていません'
    end

    it 'ログインページで各フィールドに入力し「ログイン」を押すとログインできる' do
      visit '/login'
      within "#login-form" do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: password
        click_on 'ログイン'
      end
      expect(page).to have_content(user.name), 'ログインできていません'
      expect(page).to have_current_path('/'), 'トップページに遷移できていません'
    end

    it '入力内容に不備があった場合エラーメッセージが表示されている' do
      visit '/login'
      within "#login-form" do
        click_on 'ログイン'
      end
      expect(page).to have_css('li.error-message'), 'エラーメッセージが表示されていません'
    end
  end

  describe '登録情報変更' do
    let(:user) { create(:user, name: 'default', email: 'default@test.com') }
    it '更新用の各フォームに入力し「更新」を押すと登録情報が更新されている' do
      login(user)
      visit '/mypage'
      within "#update-form" do
        fill_in 'ユーザー名', with: 'edited'
        fill_in 'メールアドレス', with: 'edited@test.com'
        click_on '更新'
      end
      expect(page.find("#update-form")).to have_field('name-form', with: 'edited'), '名前が変更できていません'
      expect(page.find("#update-form")).to have_field('email-form', with: 'edited@test.com'), 'メールアドレスが変更できていません'
    end

    it '入力内容に不備があると登録情報が更新されない' do
      login(user)
      visit '/mypage'
      within "#update-form" do
        fill_in 'ユーザー名', with: ''
        click_on '更新'
      end
      expect(page).to have_css('li.error-message'), 'エラーメッセージが表示されていません'
    end
  end

  describe '退会' do
    it '退会ボタンを押すと退会できる' do
      user = create(:user)
      n = User.count
      login(user)
      visit '/mypage'
      click_on '退会'
      page.driver.browser.switch_to.alert.accept
      sleep 1
      expect(User.count).to eq n-1
    end
  end
end
