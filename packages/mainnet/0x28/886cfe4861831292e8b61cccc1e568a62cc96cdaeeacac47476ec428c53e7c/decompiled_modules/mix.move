module 0x28886cfe4861831292e8b61cccc1e568a62cc96cdaeeacac47476ec428c53e7c::mix {
    struct MIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MIX>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MIX>(arg0, b"MIX", b"mixmax", x"4d49584d41582069732061206d656d652d706f776572656420746f6b656e206275696c7420627920746865204d69786d61782041697264726f702048756e74657220636f6d6d756e6974792e204675656c65642062792068756d6f722c20687573746c652c20616e64205765623320656e6572677920e28094204d495820656d706f7765727320746865206e6578742067656e65726174696f6e206f662063727970746f2068756e746572732066726f6d2076696c6c61676520746f20746865206d6f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTSwMS8gDt36tbssCM6JVSCC1v4UewC6JsVupbUC9XAbu")), b"www.mixmax.com", b"x.com/angelineleana", b"DISCORD", b"https://t.me/mixmaxairdrophunter", 0x1::string::utf8(b"00990aae9c08a57d4f9660926df9c0949084a27d508fbf214321651220da591a5dbb80b0d2dbc511df6032b1e97056d71b90df722a187d5582d20ffcefba19140ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748275707"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

