module 0xa49c657864c3eda40c1d7b6ad52deb11872d4ae38f2a1ca1c3afa2909b03086d::nut {
    struct NUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<NUT>(arg0, 9656368953204846292, b"One Nut", b"NUT", b"Get your nut", b"https://images.hop.ag/ipfs/QmTLPQ8GA8ByPrYhBMe2r1voU3ATdtktkLZPe4YFiTULw6", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

