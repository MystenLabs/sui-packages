module 0x313a1d97b974774987ec65bcf843ce8f42a05d8c5358432c08e65c65aadf2ef0::trojan {
    struct TROJAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROJAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TROJAN>(arg0, arg1);
        0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::gauge_cap::grant_create_cap(&v0, 0x2::tx_context::sender(arg1), arg1);
        0x2::package::burn_publisher(v0);
    }

    // decompiled from Move bytecode v6
}

