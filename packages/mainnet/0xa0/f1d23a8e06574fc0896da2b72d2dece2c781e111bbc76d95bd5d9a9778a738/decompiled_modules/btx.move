module 0xa0f1d23a8e06574fc0896da2b72d2dece2c781e111bbc76d95bd5d9a9778a738::btx {
    struct BTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BTX>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BTX>(arg0, b"BTX", b"BEETHOVEN", b"The BEETHOVEN gold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdTKooyHyGYrZigFr4cxLATjL6MEvuwnWEsNt4LCEyZ3g")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007747728981931f39e4d304eeb6ead916161b50f18d05fcd8d400f5d46ec50dbd65e3e112729ba9f76fc5046a6c98f878d4cdd734f1e209f4175aba95c3171705f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631740643418"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

