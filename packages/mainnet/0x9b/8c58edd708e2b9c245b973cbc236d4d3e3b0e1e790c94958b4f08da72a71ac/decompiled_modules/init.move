module 0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::config::new<INIT>(&arg0, arg1);
        0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::config::borrow_mut_id(&mut v0), arg1);
        0x2::transfer::public_share_object<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

