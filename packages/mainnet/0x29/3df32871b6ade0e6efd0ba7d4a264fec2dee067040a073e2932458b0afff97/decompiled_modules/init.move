module 0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::create_pyth_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

