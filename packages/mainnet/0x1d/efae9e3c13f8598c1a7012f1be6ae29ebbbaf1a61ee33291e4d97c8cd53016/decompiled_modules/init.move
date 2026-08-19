module 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::config::new<INIT>(&arg0, arg1);
        0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::config::borrow_mut_id(&mut v0), arg1);
        0xc04c0827cfad5235292c0002154bbb34a93f4367c4cc740347e75d2e924a10c2::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

