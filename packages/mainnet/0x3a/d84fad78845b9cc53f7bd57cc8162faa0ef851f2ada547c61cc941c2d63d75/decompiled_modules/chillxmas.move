module 0x3ad84fad78845b9cc53f7bd57cc8162faa0ef851f2ada547c61cc941c2d63d75::chillxmas {
    struct CHILLXMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLXMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLXMAS>(arg0, 6, b"CHILLXMAS", b"CHILLXMAS On Sui", b"Just chilling on Sui all season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_03_03_00_47_29f7eb3e28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLXMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLXMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

