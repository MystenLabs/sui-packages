module 0xa5586991342756175f15c76009c6f358db953eeca0f2f04a391a1d7c06e15f62::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHIB>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHIB>(arg0, b"SHIB", b"ShIBUYA", b"come here to play", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcoY1W8sowvMKBXcP1dLFufSR6u5aBmtRkPqyzwz2EN2N")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007c683c378977ecf8ac84242b05e1addb5874f0ebfca992d01654277734a650c4ce3e8da3720b755fe9814acd13d51c4405ef162a937bb6306f738f8bd950e005d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747833823"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

