module 0x1920c429bdb30f6cd56a015ae88aad9a75c55c1e79ec1de5965d5b5f93cc807f::myst {
    struct MYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYST>(arg0, 6, b"MYST", b"Myst Privacy", b"Empowering Privacy with The Precision Of AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734854795229.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

