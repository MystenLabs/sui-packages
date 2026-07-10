module 0xb1b653022a91d57b82bd151965ca6c8ef4f26b2b2740158e19685a57924d8166::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb1b653022a91d57b82bd151965ca6c8ef4f26b2b2740158e19685a57924d8166::config::new<INIT>(&arg0, arg1);
        0xb1b653022a91d57b82bd151965ca6c8ef4f26b2b2740158e19685a57924d8166::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xb1b653022a91d57b82bd151965ca6c8ef4f26b2b2740158e19685a57924d8166::config::borrow_mut_id(&mut v0), arg1);
        0xb1b653022a91d57b82bd151965ca6c8ef4f26b2b2740158e19685a57924d8166::vault::create_vault_and_share<INIT>(&arg0, 0xb1b653022a91d57b82bd151965ca6c8ef4f26b2b2740158e19685a57924d8166::config::borrow_mut_id(&mut v0), arg1);
        0x2::transfer::public_share_object<0xb1b653022a91d57b82bd151965ca6c8ef4f26b2b2740158e19685a57924d8166::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

