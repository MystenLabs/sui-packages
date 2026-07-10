module 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::create_registry<INIT>(&arg0, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::borrow_mut_id(&mut v0), arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

