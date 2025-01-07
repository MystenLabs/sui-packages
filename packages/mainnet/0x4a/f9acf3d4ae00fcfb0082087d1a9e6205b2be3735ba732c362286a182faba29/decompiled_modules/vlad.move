module 0x4af9acf3d4ae00fcfb0082087d1a9e6205b2be3735ba732c362286a182faba29::vlad {
    struct VLAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLAD>(arg0, 6, b"VLAD", b"Vlad", b"He knows he looks fantastic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_09_10_15_53_09279c27a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VLAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

