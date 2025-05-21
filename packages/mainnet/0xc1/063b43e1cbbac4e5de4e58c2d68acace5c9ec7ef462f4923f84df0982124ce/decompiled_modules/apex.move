module 0xc1063b43e1cbbac4e5de4e58c2d68acace5c9ec7ef462f4923f84df0982124ce::apex {
    struct APEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<APEX>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<APEX>(arg0, b"APEX", b"APEX AI", b"Apex AI is pioneering advanced medical AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTnfR26uymJ1NhpgvB36J36T8iM4sD67Z2XRH49uXZwnn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001d8dca7d75acba6e57ca6ea0e027cbef65e725a86c9afb47e1bc0fd2cde6d71da37c55a5405ac32b7cb119a97558803f8d13d1687aebb224bfa06ea3511e3104d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747845470"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

