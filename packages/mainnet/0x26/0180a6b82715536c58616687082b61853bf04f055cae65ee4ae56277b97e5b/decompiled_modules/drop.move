module 0x260180a6b82715536c58616687082b61853bf04f055cae65ee4ae56277b97e5b::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DROP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DROP>(arg0, b"DROP", b"DropCoinXRPL", b"Hi, my name is Drop!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQDD9YAvhHaduNjETZcVHME1BhyHpaNQnUXa8tq6sm2Jx")), b"WEBSITE", b"https://x.com/DropCoin", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0011802c5e1d87fb790fd132f2af4b2c833dcc3f89322269e29b10dd33d801dbd78ef8dfa2fb4e25a1e7fab368083bafca98e2527fae186611abc18544840ab806d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757714"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

