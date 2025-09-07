module 0xb058fbd7b2b82ba860f87f52baeedace864a5c8fa37153f02e30905fd87e858b::hs {
    struct HS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<HS>(arg0, b"HS", b"HAM SUI", b"Best Meat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRe317VeDoGPJYfA9puw6kfkQcTihGt8xUkfi45Tuhxts")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00149fbf4596c25cb617093a16953fccb8581b3361016ad235f957441b5182bfa97fc91b865262565731daf4cf756d82e6e87122aedaf194fe0bee3c9557ccba03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757260943"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

