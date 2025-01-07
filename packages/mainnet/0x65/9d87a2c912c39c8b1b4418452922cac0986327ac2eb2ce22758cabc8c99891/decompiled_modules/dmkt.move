module 0x659d87a2c912c39c8b1b4418452922cac0986327ac2eb2ce22758cabc8c99891::dmkt {
    struct DMKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMKT>(arg0, 6, b"DMKT", b"DANDY MEERKAT", b"Always on the lookout for the next big trend. Dandy Meerkat is standing tall in the meme world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_024611873_7d4d7bb699.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

