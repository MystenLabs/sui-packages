module 0xe91162f7befbfde9cf393aefc800bd04444aa32a079be099644e78be96d33960::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BLUEY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BLUEY>(arg0, b"BLUEY", b"Bluey", b"Your favorite blue pup just hit the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVMXpYME9R3svQD8ipadfUJiebWAitPVSmNxX3rn6kEoC")), b"https://suisidesquad.com/bluey-nft/", b"https://x.com/Blueyonsui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00691a40760b0c1b450ca42429b14e52c4a0c9bb36bdc5eb7f2018be8747523758486000e0d7ca571e1d84833d03ed1e612c198010bda6ac7d27514745b5517b04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747842379"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

