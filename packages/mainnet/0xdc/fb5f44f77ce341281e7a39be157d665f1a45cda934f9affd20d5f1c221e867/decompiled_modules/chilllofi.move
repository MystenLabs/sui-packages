module 0xdcfb5f44f77ce341281e7a39be157d665f1a45cda934f9affd20d5f1c221e867::chilllofi {
    struct CHILLLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLLOFI>(arg0, 6, b"CHILLLOFI", b"Just a chill Lofi", b"Just a chill logi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735741239293.158595")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLLOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLLOFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

