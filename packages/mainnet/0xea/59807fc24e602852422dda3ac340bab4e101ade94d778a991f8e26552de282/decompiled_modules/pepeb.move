module 0xea59807fc24e602852422dda3ac340bab4e101ade94d778a991f8e26552de282::pepeb {
    struct PEPEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PEPEB>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PEPEB>(arg0, b"PEPEB", b"PEPE BOOST", b"pepe boost to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPhpJuBgUSkAqVDd3MxUbBidXqy6s2VrwovdNf3hu6JBL")), b"WEBSITE", b"https://x.com/PepeBoostMan", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00738de451846878eadfd218eafef93180ecfefb63b376bfb51951afe8d7b6acfe63234174a3041cf54fe6bb0763d3ac288114760b4b0c8ccfaa21a5ab5139fe0fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748056493"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

