module 0x8d1dc6f50a6abc8f81eacee3161c930fb6aebbf625697198f8ce5a9856a9ba91::ccip_receiver {
    struct CCIP_RECEIVER has drop {
        dummy_field: bool,
    }

    struct CCIPReceiverState has store, key {
        id: 0x2::object::UID,
    }

    public fun ccip_receive() {
        abort 1
    }

    fun init(arg0: CCIP_RECEIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CCIPReceiverState{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<CCIPReceiverState>(v0);
    }

    // decompiled from Move bytecode v6
}

