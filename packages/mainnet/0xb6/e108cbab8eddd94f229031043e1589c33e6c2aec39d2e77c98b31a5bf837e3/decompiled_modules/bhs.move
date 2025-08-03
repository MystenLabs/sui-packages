module 0xb6e108cbab8eddd94f229031043e1589c33e6c2aec39d2e77c98b31a5bf837e3::bhs {
    struct BHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHS>(arg0, 6, b"BHS", b"BAHUSA", b"Gaming is going to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaj7hjjw4nwrzpn3jvmmkawtlqdbww72roitzlnaicpb6x7rhp6oe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BHS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

