module 0x3acfa89c7c98496f3d347fe02822b8835092635debb51465ad3894fef18a90e9::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEAN>(arg0, 6, b"Ocean", b"Real Ocean", x"4f6365616e732020457874656e73696f6e20696e20535549204e6574776f726b200a5765276c6c204d616b6520426c6f636b636861696e20576574746572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lokooo_81b0e2aef7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

