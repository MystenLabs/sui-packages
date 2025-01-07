module 0xe5f457b0c5d44a7d7682395bc168d84a534381d442bdb5cec24380676bc3936c::geco {
    struct GECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECO>(arg0, 6, b"GECO", b"Geco", x"244765636f20546865204765636b6f200a4669727374204d6174742046757269652773204d656d6520636f696e206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F_5b_LS_Ji_400x400_a91caab0bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

