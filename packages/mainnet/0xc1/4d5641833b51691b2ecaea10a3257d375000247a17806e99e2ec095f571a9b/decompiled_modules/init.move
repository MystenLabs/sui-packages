module 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::create_config<INIT>(&arg0, arg1);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::borrow_mut_id(&mut v0), arg1);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

