module 0x3e2732fdca3708f177c92571dba6073d13e9ee61760dfb7646a25ff4a88c0370::oiia {
    struct OIIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIIA>(arg0, 6, b"OIIA", b"Oiia ", b"OIIA OIIA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735980574887.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OIIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

