module 0x38fc171577f044b09c24b3b80986e1a708e8f5458906194ae01783497424dda1::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX>(arg0, 9, b"SPX", b"SPX6900 SUI", b"Welcome to the S&P6900, an advanced blockchain cryptography token with limitless possibilities and scientific utilization. Imagine the power of the whole entire stock market put inside little tiny crypto coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmdVwtAHApeTE9ne7s7bVNxxLE9iFX86AQG9ebbteCD3vF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

