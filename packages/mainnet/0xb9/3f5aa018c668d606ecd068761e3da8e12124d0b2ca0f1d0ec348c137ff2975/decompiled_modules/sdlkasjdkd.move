module 0xb93f5aa018c668d606ecd068761e3da8e12124d0b2ca0f1d0ec348c137ff2975::sdlkasjdkd {
    struct SDLKASJDKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDLKASJDKD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<SDLKASJDKD>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<SDLKASJDKD>(arg0, b"SDLKASJDKD", b"SDJKDSLKJ", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0090c16116bd803480316c80a4dca1a6a7e6359ff78aa60defc45fb10df76b8353d252d81b2fc4088d8d84c6cc52a6ed2c0788752cb058c8685330aac09721140ff5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744112734"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

