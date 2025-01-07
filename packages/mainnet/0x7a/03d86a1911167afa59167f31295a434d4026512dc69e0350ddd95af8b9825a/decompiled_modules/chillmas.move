module 0x7a03d86a1911167afa59167f31295a434d4026512dc69e0350ddd95af8b9825a::chillmas {
    struct CHILLMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLMAS>(arg0, 6, b"CHILLMAS", b"ChillxMas", b"SAFE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_01_17_53_15_88693625b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

