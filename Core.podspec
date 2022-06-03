# frozen_string_literal: true

Pod::Spec.new do |s|
  s.name = 'Core'

  s.version = '1.0'
  s.summary = 'Primitive types for building a design system'

  s.homepage = 'https://github.com/squareup/market'
  s.license = { type: 'Proprietary', text: '© 2020 Square, Inc.' }
  s.author = { 'UI Systems' => 'ui-systems-native@squareup.com' }
  s.source = { git: 'ssh://org-49461806@github.com/squareup/market.git', tag: "1.0" }

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  s.dependency 'BlueprintUI'
  s.dependency 'BlueprintUICommonControls'

  s.dependency 'ListableUI'
  s.dependency 'BlueprintUILists'

  s.source_files = 'Core/Sources/**/*.{swift}'
end
