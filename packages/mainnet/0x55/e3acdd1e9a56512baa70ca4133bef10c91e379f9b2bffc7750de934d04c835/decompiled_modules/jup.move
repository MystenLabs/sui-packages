module 0x55e3acdd1e9a56512baa70ca4133bef10c91e379f9b2bffc7750de934d04c835::jup {
    struct JUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUP>(arg0, 9, b"JUP", b"JUP", b"JUPJUPJUP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bulltrend-images.s3.amazonaws.com/images/2471a00321f456162867e29edf5c1be7fb13a5380dddcf4a4b13ffa5e01349d9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUP>>(v2, @0xf55443938e7ecdc1181f60d605c77013d29a4fcf1362658e6fda627cd25cfc2c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

