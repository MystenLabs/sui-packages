module 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

