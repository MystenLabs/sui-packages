module 0x71150a82411d504985268bd8114beaaa5fbebf4542540adc63b8c9584f32af46::reborn {
    struct REBORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<REBORN>(arg0, b"REBORN", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYDjCAoUAqhgvVW4UExGgMdzPFtHJ6HW61NkjWz7UXeSg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ce28cc46bb036553b202f16b7cdd12e2a647bc8e7a2bd86fcd9166e5b84610f0a80c373601612b324310cb57d263b6c59d58e4d7c3f6b95cff6d170037db820cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749641024"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REBORN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

