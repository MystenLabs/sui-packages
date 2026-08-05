module 0xe2a0650208243bdc9850e20dc89d381debc8b399996dafb5013713f5c2fa1d38::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe2a0650208243bdc9850e20dc89d381debc8b399996dafb5013713f5c2fa1d38::registry::create_registry<INIT>(&arg0, arg1);
        0xe2a0650208243bdc9850e20dc89d381debc8b399996dafb5013713f5c2fa1d38::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xe2a0650208243bdc9850e20dc89d381debc8b399996dafb5013713f5c2fa1d38::registry::borrow_mut_id(&mut v0), arg1);
        0xe2a0650208243bdc9850e20dc89d381debc8b399996dafb5013713f5c2fa1d38::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

