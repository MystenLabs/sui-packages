module 0x1b1d19fbecacb96fb82b65aa1a8e8230e3d876e1e812b6b3616484436fa906a0::bbl {
    struct BBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<BBL>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<BBL>(arg0, b"BBL", b"Bubble", b"The bubble", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/64182f3f-14e5-4a54-8cf6-3a2b3e898313")), b"bubble.com", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b6e1dc8029ae12a2d5c6eef03a88b4a40aa3a6927c8ce909fce15097c5cd1354de27eea44cec3f8e72f56d22e7a43fd5be57eaf4eb4df4f7a7f90a6749527a0ff5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737467617"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

