require 'spec_helper'
require 'i18n/bamboo/fertilizer'

RSpec.describe 'I18n monkey patching' do
  let(:available_locales) { [:en, :zh] }

  let(:time) { Time.new(2014) }
  let(:long_time) { '2014-01-01' }
  let(:short_time) { '2014' }

  let(:key) { 'key' }
  let(:long_translation) { 'Something very long!' }
  let(:short_translation) { 'Not as long.' }

  before do
    I18n.enforce_available_locales = false
    I18n.default_locale = :en # English will always have the shortest translations for the sake of these tests
    allow(I18n).to receive(:available_locales).and_return(available_locales)
  end

  describe '#translate' do
    context 'when the :force_default_behavior option is passed in' do
      context 'when :force_default_behavior is true' do
        before do
          expect(I18n).to receive(:original_translate).with(key).and_return(short_translation)
          expect(I18n).not_to receive(:original_translate).with(key, locale: :en)
          expect(I18n).not_to receive(:original_translate).with(key, locale: :zh)
        end

        it 'calls through to original_translate without modifying its arguments and returns the translation' do
          expect(I18n.translate(key, force_default_behavior: true)).to eq(short_translation)
        end
      end

      context 'when :force_default_behavior is false' do
        before do
          expect(I18n).not_to receive(:original_translate).with(key)
          expect(I18n).to receive(:original_translate)
            .with(key, locale: :en)
            .and_return(short_translation)

          expect(I18n).to receive(:original_translate)
            .with(key, locale: :zh)
            .and_return(long_translation)
        end

        it 'returns the longest translation from all available locales' do
          expect(I18n.translate(key, force_default_behavior: false)).to eq(long_translation)
        end
      end
    end

    context 'when the :force_default_behavior option is not passed in' do
      before do
        expect(I18n).not_to receive(:original_translate).with(key)
        expect(I18n).to receive(:original_translate)
          .with(key, locale: :en)
          .and_return(short_translation)

        expect(I18n).to receive(:original_translate)
          .with(key, locale: :zh)
          .and_return(long_translation)
      end

      it 'returns the longest translation from all available locales' do
        expect(I18n.translate(key)).to eq(long_translation)
      end
    end
  end

  describe '#t' do
    context 'when the :force_default_behavior option is passed in' do
      context 'when :force_default_behavior is true' do
        before do
          expect(I18n).to receive(:original_translate).with(key).and_return(short_translation)
          expect(I18n).not_to receive(:original_translate).with(key, locale: :en)
          expect(I18n).not_to receive(:original_translate).with(key, locale: :zh)
        end

        it 'calls through to original_translate without modifying its arguments and returns the translation' do
          expect(I18n.t(key, force_default_behavior: true)).to eq(short_translation)
        end
      end

      context 'when :force_default_behavior is false' do
        before do
          expect(I18n).not_to receive(:original_translate).with(key)
          expect(I18n).to receive(:original_translate)
            .with(key, locale: :en)
            .and_return(short_translation)

          expect(I18n).to receive(:original_translate)
            .with(key, locale: :zh)
            .and_return(long_translation)
        end

        it 'returns the longest translation from all available locales' do
          expect(I18n.t(key, force_default_behavior: false)).to eq(long_translation)
        end
      end
    end

    context 'when the :force_default_behavior option is not passed in' do
      before do
        expect(I18n).not_to receive(:original_translate).with(key)
        expect(I18n).to receive(:original_translate)
          .with(key, locale: :en)
          .and_return(short_translation)

        expect(I18n).to receive(:original_translate)
          .with(key, locale: :zh)
          .and_return(long_translation)
      end

      it 'returns the longest translation from all available locales' do
        expect(I18n.translate(key)).to eq(long_translation)
      end
    end
  end

  describe '#localize' do
    context 'when the :force_default_behavior option is passed in' do
      context 'when :force_default_behavior is true' do
        before do
          expect(I18n).to receive(:original_localize).with(time, {}).and_return(short_time)
          expect(I18n).not_to receive(:original_localize).with(time, locale: :en)
          expect(I18n).not_to receive(:original_localize).with(time, locale: :zh)
        end

        it 'calls through to original_localize without modifying its arguments and returns the localized value' do
          expect(I18n.localize(time, force_default_behavior: true)).to eq(short_time)
        end
      end

      context 'when :force_default_behavior is false' do
        before do
          expect(I18n).not_to receive(:original_localize).with(time)
          expect(I18n).to receive(:original_localize)
            .with(time, locale: :en)
            .and_return(short_time)

          expect(I18n).to receive(:original_localize)
            .with(time, locale: :zh)
            .and_return(long_time)
        end

        it 'returns the longest localized value from all available locales' do
          expect(I18n.localize(time, force_default_behavior: false)).to eq(long_time)
        end
      end
    end

    context 'when the :force_default_behavior option is not passed in' do
      before do
        expect(I18n).not_to receive(:original_localize).with(time)
        expect(I18n).to receive(:original_localize)
          .with(time, locale: :en)
          .and_return(short_time)

        expect(I18n).to receive(:original_localize)
          .with(time, locale: :zh)
          .and_return(long_time)
      end

      it 'returns the longest translation from all available locales' do
        expect(I18n.localize(time)).to eq(long_time)
      end
    end
  end

  describe '#l' do
    context 'when the :force_default_behavior option is passed in' do
      context 'when :force_default_behavior is true' do
        before do
          expect(I18n).to receive(:original_localize).with(time, {}).and_return(short_time)
          expect(I18n).not_to receive(:original_localize).with(time, locale: :en)
          expect(I18n).not_to receive(:original_localize).with(time, locale: :zh)
        end

        it 'calls through to original_localize without modifying its arguments and returns the localized value' do
          expect(I18n.l(time, force_default_behavior: true)).to eq(short_time)
        end
      end

      context 'when :force_default_behavior is false' do
        before do
          expect(I18n).not_to receive(:original_localize).with(time)
          expect(I18n).to receive(:original_localize)
            .with(time, locale: :en)
            .and_return(short_time)

          expect(I18n).to receive(:original_localize)
            .with(time, locale: :zh)
            .and_return(long_time)
        end

        it 'returns the longest localized value from all available locales' do
          expect(I18n.l(time, force_default_behavior: false)).to eq(long_time)
        end
      end
    end

    context 'when the :force_default_behavior option is not passed in' do
      before do
        expect(I18n).not_to receive(:original_localize).with(time)
        expect(I18n).to receive(:original_localize)
          .with(time, locale: :en)
          .and_return(short_time)

        expect(I18n).to receive(:original_localize)
          .with(time, locale: :zh)
          .and_return(long_time)
      end

      it 'returns the longest translation from all available locales' do
        expect(I18n.l(time)).to eq(long_time)
      end
    end
  end
end
