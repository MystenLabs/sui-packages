module 0x3b8af5fecab755da43ed73ebf1c6a7b5e3befad2a1e8e16c5ceb96ad502453bc::errors {
    public fun err_invalid_version() : u64 {
        abort 2
    }

    public fun err_version_deprecated() : u64 {
        abort 1
    }

    // decompiled from Move bytecode v6
}

