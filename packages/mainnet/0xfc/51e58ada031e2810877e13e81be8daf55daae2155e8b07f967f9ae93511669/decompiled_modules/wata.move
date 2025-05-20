module 0xfc51e58ada031e2810877e13e81be8daf55daae2155e8b07f967f9ae93511669::wata {
    struct WATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WATA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WATA>(arg0, b"WATA", b"ALL SUI WATA", x"57686f207361696420776520646f6e7420686176652057415441206f6e20535549200a57415441204953204e455720424954434f494e204b454550205741544120464f52204c494645", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRTtwoM1NCd971abdWeK7E1yxR4NDCVSNegTQ3DTRgvfo")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b9e8e31a34f8aae67ee4b899d1dc6db960955a2a1412e107a52328a82932c3e8b804868e7281afb707b02260c87795b06d6bd48bc7cc5b1281ef39603233a608d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758216"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

