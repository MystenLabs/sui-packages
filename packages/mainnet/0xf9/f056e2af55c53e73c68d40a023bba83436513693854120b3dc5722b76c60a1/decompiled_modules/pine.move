module 0xf9f056e2af55c53e73c68d40a023bba83436513693854120b3dc5722b76c60a1::pine {
    struct PINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PINE>(arg0, 6, 0x1::string::utf8(b"PINE"), 0x1::string::utf8(b"PINE"), 0x1::string::utf8(b"JUST A PINEAPPLE WITH SUNGLASSES. WHAT ELSE?"), 0x1::string::utf8(b"https://popularsui.xyz/media/a3d701c4de09805bc2511c0d5d3a74e8fb422a65374028dbe8ca0c733a3a2374.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PINE>>(0x2::coin_registry::finalize<PINE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

