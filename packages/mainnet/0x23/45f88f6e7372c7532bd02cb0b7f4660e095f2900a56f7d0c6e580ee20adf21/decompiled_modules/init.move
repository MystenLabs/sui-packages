module 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::create_config<INIT>(&arg0, arg1);
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::borrow_mut_id(&mut v0), arg1);
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

