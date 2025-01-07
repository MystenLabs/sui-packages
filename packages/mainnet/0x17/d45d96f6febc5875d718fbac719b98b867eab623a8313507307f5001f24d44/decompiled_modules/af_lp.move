module 0x17d45d96f6febc5875d718fbac719b98b867eab623a8313507307f5001f24d44::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b7f05485d5e171b092b6b293f74ab8b86a4f5d9b3eccfbded823150bd73c110::amm_interface::create_lp_coin<AF_LP>(arg0, 9, arg1);
    }

    // decompiled from Move bytecode v6
}

