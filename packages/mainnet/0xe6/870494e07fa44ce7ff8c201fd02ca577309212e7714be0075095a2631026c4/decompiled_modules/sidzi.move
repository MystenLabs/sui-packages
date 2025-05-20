module 0xe6870494e07fa44ce7ff8c201fd02ca577309212e7714be0075095a2631026c4::sidzi {
    struct SIDZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDZI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SIDZI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SIDZI>(arg0, b"SIDZI", b"PIN", b"1 SIDZI = 1 rice bowl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmah9S2XweWZKLzXBe2jh4eFXWPqkQvaSWAZyzMDPowZGD")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007b009eab19264a0800cd4f711959387ebd971d3fe06f8d0f2f63ca7f719b8ef80692e2a68059c9e838429d176068304fbc24f2422d09904428ffcd4ba8d4e903d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758465"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

