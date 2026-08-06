module 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::create_config<INIT>(&arg0, arg1);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::borrow_mut_id(&mut v0), arg1);
        0x45a7f9bfb046a4c7eb5c9b73e5d2cb52be0e06e1320a5923c0587ac944730647::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

