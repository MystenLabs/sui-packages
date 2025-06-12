module 0x45a2bb9f2324812d957b56a3d30a3e96ac7478e2bc7f29a1d24c99c997568059::wtc {
    struct WTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTC>(arg0, 6, b"WTC", b"Wit Crock", b"Witc Crock is a reflection of the light of a green candle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiewpv2rcmxhinui24qyj6cuypc7eymutt3k3obuzdk3iwy7bcbkee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

