module 0xef8137eb93afd67cfd16930ec7482e37bfb8fb2bdfee5409af3815c735ede38c::africa {
    struct AFRICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFRICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<AFRICA>(arg0, b"Africa", b"SuiNetwork Africa", b"Scaling Sui & Sui Move across Africa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmd6ESHWK5yYsGYZrpdjs3C7779MzrhHa5wJrvhUqbhKfm")), b"WEBSITE", b"https://x.com/SuiMoveAfrica", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00616614dc4c8accfcf442907d1f424e46d8428b4a9641378d03d890da6ec23a4d4714bb738ecbb1bb1b222339985b67081b606fa9d9f4188ebd04cc0cf9b0ae03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757051338"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFRICA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

