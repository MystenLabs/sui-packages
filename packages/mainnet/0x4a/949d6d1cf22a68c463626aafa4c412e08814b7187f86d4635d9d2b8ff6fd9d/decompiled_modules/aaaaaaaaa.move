module 0x4a949d6d1cf22a68c463626aafa4c412e08814b7187f86d4635d9d2b8ff6fd9d::aaaaaaaaa {
    struct AAAAAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAAAAA>(arg0, 6, b"AAAAAAAAA", b"AAAA", b"A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_T_12_Les_400x400_1_0d27006bd7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

