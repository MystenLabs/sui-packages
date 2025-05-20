module 0x8e7d9b5e914b41a6078e8a555229e62ac82480d323e73a6bce2f77e9c1f0966d::shippo {
    struct SHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHIPPO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHIPPO>(arg0, b"SHIPPO", b"SPLASH HIPPO", x"53484950504f20e280932074686520667573696f6e206f66206c6567656e6461727920484950504f20616e6420746865206e657720776176652066726f6d2053706c6173682e78797a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVzQpVKLprrkXkoo4r3vFHAiH4TYGKmDbTve5xdLFmuwK")), b"https://shippo.fun/", b"https://x.com/SHIPPO_SUI", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0054e32edcf3bdd65d3d47a92c1d2ac2cba6f3a591d172fd343654ca3aec1e7efaef317754dcbaea8801747d4ee1933c6674928d923380a17ca237cd1682aa2b03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756966"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

