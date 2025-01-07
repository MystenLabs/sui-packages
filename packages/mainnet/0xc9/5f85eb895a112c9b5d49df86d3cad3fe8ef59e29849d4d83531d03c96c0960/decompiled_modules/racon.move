module 0xc95f85eb895a112c9b5d49df86d3cad3fe8ef59e29849d4d83531d03c96c0960::racon {
    struct RACON has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACON>(arg0, 6, b"RACON", b"Racoon Verse & 6 Legendary Clans", x"54686520756c74696d617465206d656d6520636f696e206f6e2053756920210a43686f6f736520796f757220636c616e20616e64206a6f696e20746865206368616f73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7a379537_f769_453f_b0b8_da16306a2d1b_a39f149ec5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACON>>(v1);
    }

    // decompiled from Move bytecode v6
}

