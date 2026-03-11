module 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::create_pyth_lazer_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

