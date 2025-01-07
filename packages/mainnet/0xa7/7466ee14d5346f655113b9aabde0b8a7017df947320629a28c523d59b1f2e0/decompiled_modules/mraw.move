module 0xa77466ee14d5346f655113b9aabde0b8a7017df947320629a28c523d59b1f2e0::mraw {
    struct MRAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRAW>(arg0, 6, b"MRAW", b"MRAWSUI", b"$MRAW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_00_59_54_18bf28a853.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

