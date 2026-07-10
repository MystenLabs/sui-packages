module 0x213b3a1209d1d0094b757bea5e07739a11760baa818c8a1d3a9116e4c645228f::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x213b3a1209d1d0094b757bea5e07739a11760baa818c8a1d3a9116e4c645228f::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

