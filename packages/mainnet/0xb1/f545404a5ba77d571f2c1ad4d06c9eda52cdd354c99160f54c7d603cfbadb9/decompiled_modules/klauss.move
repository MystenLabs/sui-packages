module 0xb1f545404a5ba77d571f2c1ad4d06c9eda52cdd354c99160f54c7d603cfbadb9::klauss {
    struct KLAUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLAUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLAUSS>(arg0, 6, b"KLAUSS", b"KLAUS", b"KLAUS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_15_08_04_0d173d6055.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLAUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLAUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

