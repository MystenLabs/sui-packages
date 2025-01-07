module 0xb67b5c4e3bded780b93eba77cfddf14f2277f7e73ce443f1e5cfc19f70ec8c0a::fp {
    struct FP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FP>(arg0, 9, b"FP", b"Fluffy Pickle", b"Meet Fluffy Pickle, our adorable mascot! Soft, green, and ready to bring a smile to the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6rRHwTdDAJwFYNdU4Z6CVGSwgTjBAaqMAj1w1kpopump.png?size=lg&key=463fae")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FP>>(v1);
    }

    // decompiled from Move bytecode v6
}

