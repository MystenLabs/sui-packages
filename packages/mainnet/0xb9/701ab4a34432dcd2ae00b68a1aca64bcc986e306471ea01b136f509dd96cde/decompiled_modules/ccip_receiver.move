module 0xb9701ab4a34432dcd2ae00b68a1aca64bcc986e306471ea01b136f509dd96cde::ccip_receiver {
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

