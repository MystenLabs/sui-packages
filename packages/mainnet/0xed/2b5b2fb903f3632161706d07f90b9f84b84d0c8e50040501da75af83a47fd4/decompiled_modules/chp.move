module 0xed2b5b2fb903f3632161706d07f90b9f84b84d0c8e50040501da75af83a47fd4::chp {
    struct CHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHP>(arg0, 6, b"Chp", b"Chip", b"Trading AI Sniffer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736447120461.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

