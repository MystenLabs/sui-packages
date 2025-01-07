module 0x7be44618405aba19db5498948f898758dd3697a9516547f01930a25e36800ef::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0xf7e5b9743f273b9940ff8b9b488067fa30ac993b036d3cf82c8e1bebec75bf59::amm_interface::create_lp_coin<AF_LP>(arg0, 9, arg1);
    }

    // decompiled from Move bytecode v6
}

