module 0x7a101e0c2f53400e7df71de64e458485322ee9eab5155e6dea3f931f4aca3ffb::pisui {
    struct PISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISUI>(arg0, 6, b"PISUI", b"Pinky CTO Sui", x"4a6f696e206f7572207465616d3a2068747470733a2f2f70696e6b796f6e7375692e6f72670a68747470733a2f2f782e636f6d2f50696e6b795f5375690a68747470733a2f2f742e6d652f50696e6b795355495f4f696e6b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_14_80f646a9b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

