module 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::create_config<INIT>(&arg0, arg1);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::borrow_mut_id(&mut v0), arg1);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

