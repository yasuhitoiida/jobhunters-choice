require 'rails_helper'

RSpec.describe 'Analysis', type: :system do
  let(:criterion_number) { 3 }
  let(:alternative_number) { 3 }
  describe 'STEP1' do
    before { visit '/step1' }
  it '入力された選択肢が2つ以上のとき次ページに遷移する' do
      alternative_input(2)
      expect(page).to have_current_path('/step2'), '次ページに遷移していません'
    end

  it '入力された選択肢が2つ未満のときエラーメッセージが表示される' do
      alternative_input(1)
      expect(page).to have_selector('.error-message'), 'エラーメッセージが表示されていません'
    end

  it '入力値が重複しているときエラーメッセージが表示される' do
      find('#alternative0').set('foobar')
      find('#alternative1').set('foobar')
      click_on '決定'
      expect(page).to have_selector('.error-message'), 'エラーメッセージが表示されていません'
    end

  it '前のページから戻ったとき以前の入力値が保持されている' do
      find('#alternative0').set('foobar')
      find('#alternative1').set('foobuzz')
      click_on '決定'
      click_on '戻る'
      expect(page).to have_field('alternative0', with: 'foobar'), '以前の入力値が保持されていません'
      expect(page).to have_field('alternative1', with: 'foobuzz'), '以前の入力値が保持されていません'
    end
  end

  describe 'STEP2' do
    before do
      visit '/step1'
      alternative_input(alternative_number)
    end
  it '条件が2つ以上選択されているとき次ページに遷移する' do
      criterion_select(2)
      expect(page).to have_current_path('/step3'), '次ページに遷移していません'
    end

  it '条件が2つ以上選択されていないときエラーメッセージが表示される' do
      criterion_select(1)
      expect(page).to have_selector('.error-message'), 'エラーメッセージが表示されていません'
    end

  it '追加した条件が他の条件と重複しているときエラーメッセージが表示される' do
      find('#addedCriteria').set(find('#criterion0', visible: false).value)
      click_on '条件を追加'
      expect(page).to have_selector('.error-message'), 'エラーメッセージが表示されていません'
    end

  it '前のページから戻ったとき以前の入力値が保持されている' do
      check('criterion0', allow_label_click: true)
      check('criterion1', allow_label_click: true)
      click_on '決定'
      click_on '戻る'
      expect(page).to have_checked_field('criterion0', visible: false), '以前の入力値が保持されていません'
      expect(page).to have_checked_field('criterion1', visible: false), '以前の入力値が保持されていません'
    end
  end

  describe 'STEP3' do
    before do
      visit '/step1'
      alternative_input(alternative_number)
      criterion_select(criterion_number)
    end
  it 'ラジオボタンがすべて押されているとき次ページに遷移する' do
      criterion_importance(criterion_number)
      expect(page).to have_current_path('/step4'), '次ページに遷移していません'
    end

  it 'ラジオボタンがすべて押されていないときエラーメッセージが表示される' do
      criterion_importance(criterion_number-1)
      expect(page).to have_selector('.error-message'), 'エラーメッセージが表示されていません'
    end

  it '前のページから戻ったとき以前の入力値が保持されている' do
      within "div[id='0-0']" do
        find_button('1').click
      end
      sleep 0.5
      within "div[id='0-1']" do
        find_button('2').click
      end
      sleep 0.5
      within "div[id='0-2']" do
        find_button('3').click
      end
      sleep 0.5
      click_on '決定'
      click_on '戻る'
      expect(find("div[id='0-0']")).to have_selector('.v-btn--active', text: '1'), '以前の入力値が保持されていません'
      expect(find("div[id='0-1']")).to have_selector('.v-btn--active', text: '2'), '以前の入力値が保持されていません'
      expect(find("div[id='0-2']")).to have_selector('.v-btn--active', text: '3'), '以前の入力値が保持されていません'
    end
  end

  describe 'STEP4' do
    before do
      visit '/step1'
      alternative_input(alternative_number)
      criterion_select(criterion_number)
      criterion_importance(criterion_number)
    end
  it "ラジオボタンがすべて押されているとき次ページに遷移する" do
      alternative_evaluation(criterion_number, alternative_number)
      expect(page).to have_current_path('/result'), '次ページに遷移していません'
    end

  it "ラジオボタンがすべて押されていないときエラーメッセージが出る" do
      alternative_evaluation(criterion_number, alternative_number-1)
      expect(page).to have_selector('.error-message'), 'エラーメッセージが表示されていません'
    end

  it '前のページから戻ったとき以前の入力値が保持されている' do
      3.times do |n|
        within "div[id='#{n}-0']" do
          find_button('1').click
        end
        sleep 0.5
        within "div[id='#{n}-1']" do
          find_button('2').click
        end
        sleep 0.5
        within "div[id='#{n}-2']" do
          find_button('3').click
        end
        sleep 0.5
      end
      click_on '決定'
      click_on '戻る'
      expect(find("div[id='0-0']")).to have_selector('.v-btn--active', text: '1'), '以前の入力値が保持されていません'
      expect(find("div[id='0-1']")).to have_selector('.v-btn--active', text: '2'), '以前の入力値が保持されていません'
      expect(find("div[id='0-2']")).to have_selector('.v-btn--active', text: '3'), '以前の入力値が保持されていません'
      expect(find("div[id='1-0']")).to have_selector('.v-btn--active', text: '1'), '以前の入力値が保持されていません'
      expect(find("div[id='1-1']")).to have_selector('.v-btn--active', text: '2'), '以前の入力値が保持されていません'
      expect(find("div[id='1-2']")).to have_selector('.v-btn--active', text: '3'), '以前の入力値が保持されていません'
      expect(find("div[id='2-0']")).to have_selector('.v-btn--active', text: '1'), '以前の入力値が保持されていません'
      expect(find("div[id='2-1']")).to have_selector('.v-btn--active', text: '2'), '以前の入力値が保持されていません'
      expect(find("div[id='2-2']")).to have_selector('.v-btn--active', text: '3'), '以前の入力値が保持されていません'
    end
  end

  describe '結果' do
    before do
      visit '/step1'
      analysis(criterion_number, alternative_number)
    end
  it '決定ボタンを押すと結果が表示される' do
      click_on '決定'
      expect(page).to have_selector('#bar-chart'), '結果が表示されていません'
    end

  end

  describe '保存' do
    let(:user) { create(:user) }
    context 'ログイン状態のとき' do
      it '保存ボタンを押すと結果が保存できる' do
        login(user)
        click_on 'START'
        analysis(criterion_number, alternative_number)
        click_on '決定'
        sleep 2
        click_on 'SAVE'
        visit current_path
        expect(Analysis.count).to eq(1), '結果が保存されていません'
        expect(CriterionImportance.count).to eq(criterion_number), '結果が保存されていません'
        expect(AlternativeResult.count).to eq(alternative_number), '結果が保存されていません'
        expect(MultipledWeight.count).to eq(alternative_number * criterion_number), '結果が保存されていません'
      end
    end

    context '未ログイン状態のとき' do
      before do
        visit '/step1'
        analysis(criterion_number, alternative_number)
        click_on '決定'
        sleep 2
        click_on 'SAVE'
      end
      it 'ログインに成功すると保存できる' do
        within '#user-modal' do
          within '#login-form' do
            fill_in 'メールアドレス', with: user.email
            fill_in 'パスワード', with: '12345678'
          end
          click_on 'ログイン'
        end
        expect(page).to_not have_css('.v-dialog'), 'モーダルが消えていません'
        expect(Analysis.count).to eq(1), '結果が保存されていません'
      end

      it 'ログインに失敗すると保存できない' do
        within '#user-modal' do
          click_on 'ログイン'
        end
        expect(page).to have_css('.v-dialog'), 'モーダルが閉じられています'
        expect(Analysis.count).to eq(0), '結果が保存されています'
      end

    end
  end

  describe 'マイページ' do
    it '分析結果を表示できる' do
      login(create(:user))
      visit '/step1'
      analysis(criterion_number, alternative_number)
      click_on '決定'
      sleep 2
      click_on 'SAVE'
      visit '/mypage'
      expect(page).to have_selector('#bar-chart')
    end
  end
end
