module 0x34cf162efe0886c9739029b451135fb3fc90b71c15fb86bd27614961614c0933::crap {
    struct CRAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAP>(arg0, 6, b"CRAP", b"Dump", b"Useless, worthless, western like", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749669233205.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

