module 0x4c6f998c1bc232bc979520f82913b89ec581c5bae66f8269f208bf7e778e9dba::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0xe69413529ab3644326061487489edc54e51ae060878c7f3a5d5526cdb7784fa1::amm_interface::create_lp_coin<AF_LP>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

