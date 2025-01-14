module 0x2b1e98d1378dae3dd9cb7f57f09ed07e3d62260bee3ca3690d86ad2002bd5bf5::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<TST>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<TST>(arg0, b"TST", b"Testy", b"Token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/fc05e0fb-3e5e-4ced-9040-6498d0370683")), b"https://www.youtube.com/", b"https://x.com/", b"https://discord.com/", b"TELEGRAM", 0x1::string::utf8(b"009533eb50deff945e88eb69951302fdac3f196cca778fbffcc59b8618a755d3d9714b6165d23476c25440971aa0d9d9a8b47542a6691703b5bcda6ad3700cd60cf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736847538"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

