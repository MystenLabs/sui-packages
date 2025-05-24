module 0x92d5dc39ce01a078c89a350313bbbce93079bce0262301eef35bbb855ca8bf2b::shp {
    struct SHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHP>(arg0, b"SHP", b"shoupe", x"53686f75706520285348502920697320612073796d626f6c206f662072617720706f77657220616e64206f6e636861696e20726562656c6c696f6e2e204675656c656420627920636f6d6d756e6974792c206172742c20616e642063727970746f206e617469766520656e657267792e204974e2809973206d6f7265207468616e206120746f6b656e206974e280997320612073746174656d656e742e204a6f696e20746865206d6f76656d656e7420616e64206265636f6d652070617274206f6620746865206c6567656e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNQ47sEz3CxBVE46V3giL1zu6MNNYughUjHiYY4WT4y1y")), b"https://warpcast.com/shoupe", b"https://x.com/eam__sha", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c44c46a8cd29e772eb0bf8f5fee851018f4002a418db6994b97073f2f0e05b5a85816eaebd2a6e89a495d7ce38df029f041baa0e3d3cdb0581e3765a2e900d09d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748111164"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

