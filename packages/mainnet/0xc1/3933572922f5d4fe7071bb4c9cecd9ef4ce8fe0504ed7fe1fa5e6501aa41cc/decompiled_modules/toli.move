module 0xc13933572922f5d4fe7071bb4c9cecd9ef4ce8fe0504ed7fe1fa5e6501aa41cc::toli {
    struct TOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLI>(arg0, 6, b"TOLI", b"Toli", b"The government may lie to you, Toli won't", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747928857716.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

