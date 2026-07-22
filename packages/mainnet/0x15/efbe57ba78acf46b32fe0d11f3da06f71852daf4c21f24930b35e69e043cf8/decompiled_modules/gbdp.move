module 0x15efbe57ba78acf46b32fe0d11f3da06f71852daf4c21f24930b35e69e043cf8::gbdp {
    struct GBDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBDP>(arg0, 9, b"GBDP", b"GBDP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/iWkWE4a_0mgsmkpK6ZGFjq_rhJneC4IBdqCCleZuQNc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GBDP>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBDP>>(v2, @0x4dc4ae114dcf6fb4e1bc66f492703a740fb8dc0d3186629e38765569dcca4f37);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

