module 0x143e7964dda1f0964af2b4f40df3c28f0b70cfcdb889438c13be99f4bbbfb4d7::po {
    struct PO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PO>(arg0, 6, b"PO", b"Pixel Origin", b"Pixels are the smallest unit in digital image representation. Each pixel has a numerical value that determines its color and intensity. And here pixels are characters in NFT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Banner_85312e0a7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PO>>(v1);
    }

    // decompiled from Move bytecode v6
}

