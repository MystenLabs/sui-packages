module 0x767aa82a0fed4d8ba4ac8c9daefc33f0eaf4c49f6aa157e44c9fb8f87582eea8::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x767aa82a0fed4d8ba4ac8c9daefc33f0eaf4c49f6aa157e44c9fb8f87582eea8::config::new<INIT>(&arg0, arg1);
        0x767aa82a0fed4d8ba4ac8c9daefc33f0eaf4c49f6aa157e44c9fb8f87582eea8::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x767aa82a0fed4d8ba4ac8c9daefc33f0eaf4c49f6aa157e44c9fb8f87582eea8::config::borrow_mut_id(&mut v0), arg1);
        0x2::transfer::public_share_object<0x767aa82a0fed4d8ba4ac8c9daefc33f0eaf4c49f6aa157e44c9fb8f87582eea8::config::Config>(v0);
        0x767aa82a0fed4d8ba4ac8c9daefc33f0eaf4c49f6aa157e44c9fb8f87582eea8::vault::create_vault_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

