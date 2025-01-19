module 0x44bec60c55e7c4233a240b804310511e6d0c18168636bf537639669035bbb1b2::natl {
    struct NATL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NATL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NATL>(arg0, 6, b"NATL", b"Nautilus Agent", b"The first DeFAI Agent on Sui Network. All-in-one through natural language", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737292788747.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NATL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NATL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

