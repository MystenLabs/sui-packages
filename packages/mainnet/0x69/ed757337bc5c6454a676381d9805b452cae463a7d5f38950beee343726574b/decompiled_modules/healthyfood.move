module 0x69ed757337bc5c6454a676381d9805b452cae463a7d5f38950beee343726574b::healthyfood {
    struct HEALTHYFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEALTHYFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEALTHYFOOD>(arg0, 9, b"HLW", b"healthyfood", b"healthy weed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/wVjLj8DI23Je_NWKg1cTsDe5VS3Fe4Mo5py6w7YVHGY")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HEALTHYFOOD>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEALTHYFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

