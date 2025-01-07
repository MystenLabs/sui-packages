module 0xdd0b79d27b58fa2664311428147a1001c511813a2980f0f82a8177f6f438565b::nubb {
    struct NUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUBB>(arg0, 6, b"Nubb", b"Nub", b"NUB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PHOTO_2024_10_12_14_04_01_0eefba16fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

