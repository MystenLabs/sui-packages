module 0x91a057e5046c5c2f618b0b192a3948f7290e127650db51a8a76a35e394cfb08a::firsttoken {
    struct FIRSTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRSTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FIRSTTOKEN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FIRSTTOKEN>(arg0, b"FIRSTTOKEN", b"FIRST", b"first is first", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVSAApBumFovkzdCcpQXWeUZT4F6JkWqXv43UBJCF8aNU")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bb30b40f9403bd97382a1d58559cb055bbddc684dd175624bc09dcfa63ba7a4440e8128312703f456a84d955f3bde28a758ae4b2ee4a0da230d54f4320514003d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747787888"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

