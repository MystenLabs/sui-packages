module 0x4c7357dfaf21d2e91fd9e8e2166588e62ffab23d842e80b5080518ec97aaaa9::grg {
    struct GRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<GRG>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<GRG>(arg0, b"GRG", b"Growth Group", b"The Growth Group", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/0dd32d61-626f-4b20-b567-c1906fd454ce")), b"https://www.spacex.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006c36884f2e47dcc2ceaeebee145970f76439d3ee8f81f54f42a3ccfa6b70456d6a019e2546a5fe6840e44a352a64232ecd6913347d0be8828fd0b786e1bf350bf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736966920"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

