module 0x9631460e27fabff6e7a2816651604e5a103c3a9dade7974d81562bbda981f758::hlwx {
    struct HLWX has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLWX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLWX>(arg0, 9, b"HLWX", b"healthyfoodX", b"healthy weed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/wVjLj8DI23Je_NWKg1cTsDe5VS3Fe4Mo5py6w7YVHGY")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HLWX>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HLWX>>(v1);
    }

    // decompiled from Move bytecode v6
}

