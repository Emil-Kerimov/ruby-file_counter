require 'rspec'
require 'fileutils'
require_relative 'script'

RSpec.describe '#script' do
  before(:all) do
    @test_dir = 'test_directory'
    Dir.mkdir(@test_dir) unless Dir.exist?(@test_dir)
    FileUtils.mkdir_p(File.join(@test_dir, 'dir1'))
    FileUtils.mkdir_p(File.join(@test_dir, 'dir2'))
    File.write(File.join(@test_dir, 'file1.txt'), 'fgdssfdga')
    File.write(File.join(@test_dir, 'dir1', 'file2.txt'), 'gasdfag')
  end

  after(:all) do
    FileUtils.rm_rf(@test_dir)
  end

  it 'correctly counts files and dirs' do
    file_count, dir_count = count_files_and_dirs(@test_dir)
    expect(file_count).to eq(2)
    expect(dir_count).to eq(2)
  end

  it 'returns zero if empty dir' do
    empty_dir = File.join(@test_dir, 'empty_dir')
    Dir.mkdir(empty_dir) unless Dir.exist?(empty_dir)
    file_count, dir_count = count_files_and_dirs(empty_dir)
    expect(file_count).to eq(0)
    expect(dir_count).to eq(0)
  end

  it 'handles non-existent directories' do
    expect { count_files_and_dirs('non_existent_directory') }.to raise_error(Errno::ENOENT)
  end
end
