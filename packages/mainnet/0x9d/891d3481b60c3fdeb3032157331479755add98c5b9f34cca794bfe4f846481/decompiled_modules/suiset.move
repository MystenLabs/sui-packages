module 0x9d891d3481b60c3fdeb3032157331479755add98c5b9f34cca794bfe4f846481::suiset {
    struct SUISET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISET>(arg0, 6, b"Suiset", b"SuisetXyz", b"SUISET is a token on the Sui network symbolizing balance and duality  sun and moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicd2o36s3v2ovwijfgywowz3ont5ye4szkxndvusfvo6ttn5ycl6m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

