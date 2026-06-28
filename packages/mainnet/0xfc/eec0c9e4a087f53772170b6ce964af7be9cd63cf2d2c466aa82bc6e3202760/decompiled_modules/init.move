module 0xfceec0c9e4a087f53772170b6ce964af7be9cd63cf2d2c466aa82bc6e3202760::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfceec0c9e4a087f53772170b6ce964af7be9cd63cf2d2c466aa82bc6e3202760::config::new<INIT>(&arg0, arg1);
        0xfceec0c9e4a087f53772170b6ce964af7be9cd63cf2d2c466aa82bc6e3202760::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xfceec0c9e4a087f53772170b6ce964af7be9cd63cf2d2c466aa82bc6e3202760::config::borrow_mut_id(&mut v0), arg1);
        0xfceec0c9e4a087f53772170b6ce964af7be9cd63cf2d2c466aa82bc6e3202760::vault::create_vault_and_share<INIT>(&arg0, 0xfceec0c9e4a087f53772170b6ce964af7be9cd63cf2d2c466aa82bc6e3202760::config::borrow_mut_id(&mut v0));
        0x2::transfer::public_share_object<0xfceec0c9e4a087f53772170b6ce964af7be9cd63cf2d2c466aa82bc6e3202760::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

