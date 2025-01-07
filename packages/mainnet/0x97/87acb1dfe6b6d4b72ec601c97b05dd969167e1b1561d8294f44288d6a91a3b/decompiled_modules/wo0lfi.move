module 0x9787acb1dfe6b6d4b72ec601c97b05dd969167e1b1561d8294f44288d6a91a3b::wo0lfi {
    struct WO0LFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WO0LFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WO0LFI>(arg0, 6, b"WO0LFI", b"WOOLFI", b"A barking shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_17_43_10_c3a83d79a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WO0LFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WO0LFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

