module 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::new<INIT>(&arg0, arg1);
        0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::borrow_mut_id(&mut v0), arg1);
        0x2::transfer::public_share_object<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

