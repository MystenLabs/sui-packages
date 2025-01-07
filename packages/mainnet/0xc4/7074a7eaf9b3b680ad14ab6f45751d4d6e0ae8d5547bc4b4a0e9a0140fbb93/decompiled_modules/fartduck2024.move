module 0xc47074a7eaf9b3b680ad14ab6f45751d4d6e0ae8d5547bc4b4a0e9a0140fbb93::fartduck2024 {
    struct FARTDUCK2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTDUCK2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTDUCK2024>(arg0, 6, b"FARTDUCK2024", b"FARTDUCK", b"THE MOST BULLISH FARTING DUCK IN CRYPTO SPACE THAT WILL BRING YOU TO THE MOON! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_27_00_35_33_0f05f73b88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTDUCK2024>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTDUCK2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

