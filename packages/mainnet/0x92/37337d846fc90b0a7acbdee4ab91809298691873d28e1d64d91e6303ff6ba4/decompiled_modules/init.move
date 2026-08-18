module 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::create_config<INIT>(&arg0, arg1);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::borrow_mut_id(&mut v0), arg1);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

