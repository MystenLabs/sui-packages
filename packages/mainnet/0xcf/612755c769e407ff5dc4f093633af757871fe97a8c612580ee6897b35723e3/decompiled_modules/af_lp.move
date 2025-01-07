module 0xcf612755c769e407ff5dc4f093633af757871fe97a8c612580ee6897b35723e3::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b7f05485d5e171b092b6b293f74ab8b86a4f5d9b3eccfbded823150bd73c110::amm_interface::create_lp_coin<AF_LP>(arg0, 9, arg1);
    }

    // decompiled from Move bytecode v6
}

