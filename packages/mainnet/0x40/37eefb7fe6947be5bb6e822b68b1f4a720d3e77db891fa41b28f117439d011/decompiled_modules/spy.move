module 0x4037eefb7fe6947be5bb6e822b68b1f4a720d3e77db891fa41b28f117439d011::spy {
    struct SPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<SPY>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<SPY>(arg0, b"SPY", b"Space", b"Space SPY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/829335c6-f9d5-41da-b42a-70e9e78515ad")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001e337d59912b6bcc9576d6cab6d24f58ef60b07e90e824b031be98d82b04bd417950f9052c3177deb24d57ab065860493a2f9284cb0a4e6a8ee7b61ce9e54a0ff5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738236395"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

