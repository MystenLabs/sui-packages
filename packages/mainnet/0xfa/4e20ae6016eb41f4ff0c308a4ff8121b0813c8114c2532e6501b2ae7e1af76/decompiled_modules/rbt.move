module 0xfa4e20ae6016eb41f4ff0c308a4ff8121b0813c8114c2532e6501b2ae7e1af76::rbt {
    struct RBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RBT>(arg0, 6, b"RBT", b"ROBOTALKS by SuiAI", x"54616c6b204c6573732c20536f6c7665204d6f726520e28094204c657420526f626f54616c6b7320646f20746865206865617679206c696674696e67207768696c6520796f7520736974206261636b20616e6420776174636820796f757220637573746f6d65727320736d696c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/E9l_I_En_NH_400x400_92a8064754.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RBT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

