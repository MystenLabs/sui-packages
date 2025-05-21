module 0xb1c90dedcf8cfa04f1cc396d72ce5b09f43bd09d27ec0eb1f81f14f1d27ec2e4::suape {
    struct SUAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUAPE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUAPE>(arg0, b"SuApe", b"Sui Apes", x"537569204170657320697320436f6d6d756e69747920546f6b656e206f6e20537569204e6574776f726b200a57652053746179202c2057652047726f77202c2057652061726520556e6974790a574520415245205355492041504553", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVuAQsP5t7HALwF3YuVtRYU5XCNS5VeMxuGjtPDNDkPKz")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b05aea51e1419db7d0672eab54ab2a2637c852c71698c10303c861b8e86f8d09f2e156a4b59ac099100b5f4ff1990d5bdbc62f3fcc09639c3f46c5cefef97401d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747842117"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

