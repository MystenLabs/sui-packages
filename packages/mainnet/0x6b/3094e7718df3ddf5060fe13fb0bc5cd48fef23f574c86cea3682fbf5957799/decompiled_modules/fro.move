module 0x6b3094e7718df3ddf5060fe13fb0bc5cd48fef23f574c86cea3682fbf5957799::fro {
    struct FRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FRO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FRO>(arg0, b"FRO", b"Frosui Amphibiano", b"Frog Token is a fun and utility-driven token on the SUI network, powering DeFi and NFT ecosystems with staking, rewards, and a vibrant community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNaJTEGmBXFB5RjVzpAMj8AnRp8KiwWbomLyUwiFv3SnV")), b"WEBSITE", b"x.com/pseudodexameth", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b941d9ab50746cad481a864e4dca5d82c1d1380b935adf4d8ff88980ed5848b1661699872ca636f8bb5fc0a06a0a3c05a3eba6044da0b6b60266693da03adf09d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748094234"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

