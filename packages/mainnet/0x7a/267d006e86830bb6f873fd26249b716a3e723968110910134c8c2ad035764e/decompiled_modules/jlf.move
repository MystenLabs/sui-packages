module 0x7a267d006e86830bb6f873fd26249b716a3e723968110910134c8c2ad035764e::jlf {
    struct JLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JLF, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<JLF>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<JLF>(arg0, b"JLF", b"JaketLusuh", b"Community Hunting Airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNUzr2AKxp54RUqoY4DHFtPTZZnf5j7C1y5SjNB25tttK")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0054942928ad870030489246f7fcb3b402927ed14904dfd71d1c34cb985806df2f399772fea31a5b83bdce434ddb0a38a497eb8c20f9e4bade11bdb6c08517c90cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748059539"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

