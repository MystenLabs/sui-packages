module 0xd9addf0688abe81ad49eb6f6781bbdf8e6e3e3ac9af5971a86b11c4b518d6108::suipe {
    struct SUIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPE>(arg0, 6, b"SUIPE", b"SuiPEPE", x"526973652066726f6d207468652061736865732c20776974682053554950452c20746865207265766f6c7574696f6e6172792063727970746f2070726f6a65637420746861742773206272696e67696e6720646563656e7472616c697a65642066696e616e6365206261636b2066726f6d2074686520646561642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIPEPE_13119052ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

