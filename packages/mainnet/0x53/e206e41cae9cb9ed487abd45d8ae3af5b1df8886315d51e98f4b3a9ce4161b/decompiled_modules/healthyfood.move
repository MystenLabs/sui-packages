module 0x53e206e41cae9cb9ed487abd45d8ae3af5b1df8886315d51e98f4b3a9ce4161b::healthyfood {
    struct HEALTHYFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEALTHYFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEALTHYFOOD>(arg0, 9, b"HLW", b"healthyfood", b"health weed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/wVjLj8DI23Je_NWKg1cTsDe5VS3Fe4Mo5py6w7YVHGY")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HEALTHYFOOD>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEALTHYFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

