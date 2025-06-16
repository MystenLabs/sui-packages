module 0x5711a4d8e64d73c7e40c8061c5bbf244d6076211c499e623db579b08b978fd31::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<DOGS>(arg0, b"DOGS", b"Token", b"BIG SUI DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWrLwEtkJxXtFkjJMHx9Z7xXRqoGZhTgqmq6DuBkJsxs3")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ea1ab0532f795d8a3b08d5d19747f1457097e47b292355029e51db2e78f6c340a173307495f94e370fdc201f6f1acbe55dfb9c31de1a844643779a8c6f995609d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1750094098"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

