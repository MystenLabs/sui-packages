module 0x1964b7ba6ee154084ddc5825ceeeaf7ad01dd9a97716004a567281666a5846a7::lst {
    struct LST has drop {
        dummy_field: bool,
    }

    fun init(arg0: LST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<LST>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<LST>(arg0, b"LST", b"Lucky sui token", b"Lucky for every early trusters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNUbupp59pgLiBfgE15kdA9fsdxbvW5cnG9BYt7Ptq6k3")), b"www.twitter/oddcrypto2", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000e265798e891b07eb666bb17d2136af05e30212d0ac2dd598d5a1e3d7b9e2ba73272d2431de9ea6e108fffe9df15d7b3414239f0fd0566ae4d5ae021ef37e30ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759713"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

