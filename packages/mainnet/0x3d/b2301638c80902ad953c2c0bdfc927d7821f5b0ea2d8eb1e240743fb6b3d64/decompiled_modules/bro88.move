module 0x3db2301638c80902ad953c2c0bdfc927d7821f5b0ea2d8eb1e240743fb6b3d64::bro88 {
    struct BRO88 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO88, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO88>(arg0, 6, b"BRO88", b"Brotastic", b"The ultimate crypto bro meme coin. More than a meme, its a brotherhood!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1585_a993a12daa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO88>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRO88>>(v1);
    }

    // decompiled from Move bytecode v6
}

