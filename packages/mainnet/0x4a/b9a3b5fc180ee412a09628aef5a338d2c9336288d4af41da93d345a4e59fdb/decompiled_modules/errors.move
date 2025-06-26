module 0x4ab9a3b5fc180ee412a09628aef5a338d2c9336288d4af41da93d345a4e59fdb::errors {
    public fun err_invalid_version() : u64 {
        abort 2
    }

    public fun err_version_deprecated() : u64 {
        abort 1
    }

    // decompiled from Move bytecode v6
}

