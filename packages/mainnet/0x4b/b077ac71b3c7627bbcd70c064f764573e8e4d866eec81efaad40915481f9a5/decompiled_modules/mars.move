module 0x4bb077ac71b3c7627bbcd70c064f764573e8e4d866eec81efaad40915481f9a5::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<MARS>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<MARS>(arg0, b"MARS", b"THE MARS", b"THE MARS ONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/a93b4dd1-be1c-4572-a689-fafa1a359f5c")), b"https://science.nasa.gov/mars/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004a707de9dfe4c141bf5682fdc70d3703d5e3cdfd7e99a450d82c0496f1fa819b0a699ac1e9a96dee5ac5fb618dc38e77731071e6fab39666d7e39844f1880a0af5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739104046"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

