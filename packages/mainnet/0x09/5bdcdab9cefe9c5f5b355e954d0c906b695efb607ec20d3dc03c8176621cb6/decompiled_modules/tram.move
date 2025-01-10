module 0x95bdcdab9cefe9c5f5b355e954d0c906b695efb607ec20d3dc03c8176621cb6::tram {
    struct TRAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAM>(arg0, 6, b"Tram", b"Tramcoin", b"My favorite tram Tatra KT8 from Prague , Czech Republic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736522120375.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

