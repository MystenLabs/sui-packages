module 0x902604bceda8fd0eb310fe473f9bb231731c82ffdeaac599fdd8587f5ecf48bb::mafioso {
    struct MAFIOSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAFIOSO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MAFIOSO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MAFIOSO>(arg0, b"Mafioso", b"Crime Drop", b"Mafioso is the most wanted \"liquid criminal\" in the Ice Kingdom. He is known for his water smuggling, secret ice trade, and liquid exfiltration operations. He is small but dangerous. His biggest enemy: Steam Detective Cool.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcG8SX2pAkrpzgd6Sev8jG8CdEw23f1z1ic7KxZyPmowR")), b"https://app.splash.xyz", b"https://x.com/crimedropsui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f95e05c26d250bc5ec8375a442eb0e24940f2cb03602666de09498ddd44a0abb53af5ed9a46bd55332ef39f422571c320d946322c2535c6c61c51722a589b502d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747774730"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

