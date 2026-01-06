module 0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::stork::create_stork_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

