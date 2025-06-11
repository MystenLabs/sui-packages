module 0x79b63a4eaf9ac2368aeb408a7e1a2a828c015bcf112c25b999386a07118c8e77::reborn {
    struct REBORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBORN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<REBORN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<REBORN>(arg0, b"REBORN", b"Token", b"DDD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYDjCAoUAqhgvVW4UExGgMdzPFtHJ6HW61NkjWz7UXeSg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002a7e0e945f0691e13f507181a5184b67272f51f63239b800db0bd417366597916dc51421f5a1be6a059aff0a9616e5d3723c62a6efb5ac9aab39113a75034d03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749633473"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

