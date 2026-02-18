module 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::config::new<INIT>(&arg0, arg1);
        0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::config::borrow_mut_id(&mut v0), arg1);
        0x2::transfer::public_share_object<0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

