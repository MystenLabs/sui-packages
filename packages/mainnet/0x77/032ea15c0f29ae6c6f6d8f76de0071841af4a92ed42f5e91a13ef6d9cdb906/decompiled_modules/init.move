module 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::new<INIT>(&arg0, arg1);
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::borrow_mut_id(&mut v0), arg1);
        0x2::transfer::public_share_object<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

