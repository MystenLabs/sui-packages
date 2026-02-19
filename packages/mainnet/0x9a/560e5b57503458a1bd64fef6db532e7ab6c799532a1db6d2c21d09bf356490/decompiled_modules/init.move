module 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::new<INIT>(&arg0, arg1);
        0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::borrow_mut_id(&mut v0), arg1);
        let v1 = 0;
        while (v1 < 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::storage_count(&v0)) {
            0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::storage::share(0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::storage::new_from_index(&mut v0, v1));
            v1 = v1 + 1;
        };
        0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

