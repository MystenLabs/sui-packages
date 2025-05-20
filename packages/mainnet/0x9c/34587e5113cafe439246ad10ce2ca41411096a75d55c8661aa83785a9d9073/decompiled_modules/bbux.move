module 0x9c34587e5113cafe439246ad10ce2ca41411096a75d55c8661aa83785a9d9073::bbux {
    struct BBUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBUX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BBUX>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BBUX>(arg0, b"BBUX", b"Bucks Bunny", b"The life changing bunny giving you bucks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWHqTbpgQtoPKBywo2a1wCwP9CwRgzWbamncvowg7tAJR")), b"Bucksbunny.cash", b"x.com/bucksbunnycash", b"DISCORD", b"t.me/bucksbunnycash", 0x1::string::utf8(b"00e77f43c94faf61e8e98d3c99a9270d1a30ce30faf41602d77eac0c185c06cdd0b20d2fdfbb89f367220aa7273cfd2cb43ff565739061be11f2945decb2d34008d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747780620"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

