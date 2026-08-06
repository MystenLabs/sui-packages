module 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::registry::create_registry<INIT>(&arg0, arg1);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::registry::borrow_mut_id(&mut v0), arg1);
        0x4fc20e5a7034c3d8a585900c0b00113441d930edff861f070bdb1b9a42e5102::registry::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

