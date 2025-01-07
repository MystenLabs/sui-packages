module 0x75d4817dc7b19fe681438d10df1cc74df0240acc486be1f5f05e10211c198341::chillxmas {
    struct CHILLXMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLXMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLXMAS>(arg0, 6, b"CHILLXMAS", b"CHILLXMAS On Sui", b"Just chilling on Sui all season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_03_03_00_47_8f7909a154.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLXMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLXMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

