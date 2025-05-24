module 0x6dc83ac78add72c21a91316aeccd47128e6591011897f737a02039f03a1e9e59::mbtc {
    struct MBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBTC>(arg0, 6, b"MBTC", b"Merlin BTC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

