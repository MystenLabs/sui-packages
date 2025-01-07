module 0x56c10fd1618d90d0b52156f228415a266d10f9013c342f0b2ae90bf4397bf488::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5013c865ff961a2ce7006e6a520b7336956419a43cf1b8d2d84837417e124dee::amm_interface::create_lp_coin<AF_LP>(arg0, 9, arg1);
    }

    // decompiled from Move bytecode v6
}

