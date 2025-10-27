module 0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::create_pyth_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

