module 0x5c850f5532b801e5f5a1819e998922122e871871bfaec41b254ebf7c4e427191::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"Mochi", b"My cute cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2024_12_28_16_50_52_98_965bbf4d18d205f782c6b8409c5773a4_da485edd5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOCHI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

