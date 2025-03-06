module 0xefbf1b05ea586210022c11af3574f35973626d7424044e91f9e42c8ba8a7be4a::raven {
    struct RAVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAVEN>(arg0, 6, b"RAVEN", b"SUI RAVEN", b"RAVEN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741280108829.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAVEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAVEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

