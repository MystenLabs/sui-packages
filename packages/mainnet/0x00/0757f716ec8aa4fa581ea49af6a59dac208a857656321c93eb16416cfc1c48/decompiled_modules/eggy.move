module 0x757f716ec8aa4fa581ea49af6a59dac208a857656321c93eb16416cfc1c48::eggy {
    struct EGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<EGGY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<EGGY>(arg0, b"Eggy", b"Eggsplode", x"546865206261627920647261676f6e204567677920626c61737473206f7574206f66206974732065676720616e6420696e746f20796f75722077616c6c6574210a426f726e20746f20626520746865206375746573742065676773706c6f73696f6e20696e2063727970746f207769746820626162796669726520656e657267792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdxNtBMXKaPkHUbDz6CGGP9bJCTvZyYqkT7AyrtzkWaJn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c51a331d5d07470df5d0c29332ce14df466cc60c2c23d1691e87277936e06cc4d6d641fbb5b7d210ae39b2877ec135274afc266f687bc33f723d546c2e1aee0cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748108525"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

