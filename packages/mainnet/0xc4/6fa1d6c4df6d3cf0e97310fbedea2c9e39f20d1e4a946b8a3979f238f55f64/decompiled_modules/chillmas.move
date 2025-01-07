module 0xc46fa1d6c4df6d3cf0e97310fbedea2c9e39f20d1e4a946b8a3979f238f55f64::chillmas {
    struct CHILLMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLMAS>(arg0, 6, b"ChillMas", b"ChillXMas", b"Safe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733073773762.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

