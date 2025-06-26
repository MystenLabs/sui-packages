module 0x3b8af5fecab755da43ed73ebf1c6a7b5e3befad2a1e8e16c5ceb96ad502453bc::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0x3b8af5fecab755da43ed73ebf1c6a7b5e3befad2a1e8e16c5ceb96ad502453bc::errors::err_version_deprecated());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x3b8af5fecab755da43ed73ebf1c6a7b5e3befad2a1e8e16c5ceb96ad502453bc::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0x3b8af5fecab755da43ed73ebf1c6a7b5e3befad2a1e8e16c5ceb96ad502453bc::errors::err_invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

