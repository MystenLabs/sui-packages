module 0xd02f6fb1f49cc391940fd96a782b320227340e261176682d2091ee5fcc6cb51e::ell {
    struct ELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELL>(arg0, 6, b"ELL", b"EL", b"adasda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734690281548.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

