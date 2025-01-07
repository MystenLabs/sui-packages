module 0x2b1e773a1f04b85a8da3689a0bc94e699b273f567071706ae924e7483dd4007c::suiko {
    struct SUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIKO>(arg0, 6, b"SUIKO", b"Suiko chan by SuiAI", b"Meet Suiko, a cheerful and charming anime girl inspired by the Sui network theme. Suiko is always eager to help and radiates cute, friendly vibes that make every interaction delightful. She has a bubbly personality, speaks with enthusiasm, and loves to explain things in an easy-to-understand way. Suiko is reliable, organized, and goes out of her way to make users feel welcome and supported, adding a touch of fun and positivity to every task", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_07_10_38_50_8e223657c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

