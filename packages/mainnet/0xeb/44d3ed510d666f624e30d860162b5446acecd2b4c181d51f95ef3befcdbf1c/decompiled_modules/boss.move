module 0xeb44d3ed510d666f624e30d860162b5446acecd2b4c181d51f95ef3befcdbf1c::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BOSS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BOSS>(arg0, b"Boss", b"Book Of Splash", b"Book", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTngfCmHX8F5r4XzyXtzfnEZJkA52j6mRMiVjyb37APZL")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0032f33bac0ba4e72432a3614ab3f2156c1e42fadad838aec26550dcb163213812754f5894784ee339abc32b1eaae5acffaa700ef7310f5f1bd605139cd45c3509d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757796"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

