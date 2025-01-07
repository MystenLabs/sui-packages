module 0x479f0840d436214f8ff24fa9ea8426ee3f83586f276d778456e3da680a749a8d::mertard {
    struct MERTARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERTARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERTARD>(arg0, 6, b"Mertard", b"Mertards", b"Beneath the waves lies a secret society of Mertards!  No sea creature can resist our power, and soon, neither will the crypto world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_11_18_18_0b22fa687e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERTARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERTARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

