module 0x5b5bc421f3dac1fc10fd79da59e38f5e53dca358c0def7f35e5b2e3947a13ead::knm {
    struct KNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNM>(arg0, 6, b"KNM", b"KNM", b"Kinome", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreibjqcnhsplycih24gdy6v3ymc2ecmfae7w2bhzfkbcsnwcvzipple")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KNM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNM>>(v2, @0x384b4f03fd3fccec0a9f0d26595e4e2b1ab289efb9213668b2f41bceb4ecd524);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

