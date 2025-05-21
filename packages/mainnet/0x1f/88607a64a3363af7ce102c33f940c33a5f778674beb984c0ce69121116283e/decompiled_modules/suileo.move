module 0x1f88607a64a3363af7ce102c33f940c33a5f778674beb984c0ce69121116283e::suileo {
    struct SUILEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUILEO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUILEO>(arg0, b"SUILEO", b"Interleon Pokemon", b"Build the first pokemon battle game on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYVE6BXYJ2E5ryyDQ9uFnYUh88SEvcwazYNN5nGtRQUB8")), b"https://www.notion.so/SUILEO-Interleon-Pokemon-Battle-Whitepaper-1faff48cdd24808c920ecea00fff2214", b"https://x.com/Suileonmeme", b"DISCORD", b"https://t.me/Suileon", 0x1::string::utf8(b"00513e8345ab06d0fca17369a0503dd0d5de22458e5a8344496419b95c2e0fd9a893acb36727919185af92b3ac5f28a2a63c5f545e177ceb6b5a37e6b569f4ef02d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747835421"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

