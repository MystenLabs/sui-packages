module 0xd7a60345af5eb6271e35d61cb5a73c6f5860c5e8250b42cecd8cfb6ca58629c::al {
    struct AL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<AL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<AL>(arg0, b"AL", b"Airdrop Listesi", b"Airdrop Listesi Community Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVpsKFtBYVBAHCWJJBgpynZzRs8R6wfs1Z8FEeiG4WsVQ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"https://t.me/AirdropListesi", 0x1::string::utf8(b"00e35c1122e9f004e90b20867b2dcd974b8e8962f0dbd5847ef52e5e7f17f509572c58260a766287a1b907f0f33b40da621f5c9a6a7e0099374d98d09926962f0dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747882173"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

