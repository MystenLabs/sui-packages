module 0x8c8ee81fb734700eeebf520e4e59e63863c6cbbe2e5a3d99c7a3f96e021f09c9::hlwx {
    struct HLWX has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLWX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLWX>(arg0, 9, b"HLWX", b"healthyfoodX", b"health weed X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/wVjLj8DI23Je_NWKg1cTsDe5VS3Fe4Mo5py6w7YVHGY")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HLWX>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HLWX>>(v1);
    }

    // decompiled from Move bytecode v6
}

