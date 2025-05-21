module 0x530ef472767b90437d936430a7369545c24f0c4a408045af3ab1e6ab43bec2ce::ploppo {
    struct PLOPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOPPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PLOPPO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PLOPPO>(arg0, b"PLOPPO", b"Ploppo The Hippo", x"4d65657420746865206261627920686970706f206f662053706c61736820e28094206120706c617966756c206c6974746c6520706c6f707065722077686f206c6f7665732073706c617368696e672061726f756e6420696e2074686520776174657273206f66205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeLY1jZobo5PJbbuhjGuT5pKGnLeep66AtxpWYH1meT4X")), b"WEBSITE", b"https://x.com/PloppoSui", b"DISCORD", b"https://t.me/plopposui", 0x1::string::utf8(b"004077de001361d7a354e3063fca656cffab4e52287914cb1b9e2823f09b9c53df107b7e44ce1727fe5d0bca2f3eb741c00b520d1e6852a13352e5b77f58553d0bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747827929"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

