module 0x2b10b8baab24e7b34860c27e1ec3534d7ad1bc5c55f82d7aea2b710b0068f5fa::liqd {
    struct LIQD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQD>(arg0, 6, b"LIQD", b"LIQUID", b"Liquid is a utility token for the Sui network designed to enhance liquidity and optimize transactions, offering fast, low-cost asset transfers and serving as a core unit for decentralized finance (DeFi) operations within the ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Liquid_f29a896f1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQD>>(v1);
    }

    // decompiled from Move bytecode v6
}

