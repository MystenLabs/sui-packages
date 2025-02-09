module 0xd3a85da5a23beafe503fa3b316f7606d75b5dc26e3ec037e445449c30082cb6::piz {
    struct PIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<PIZ>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<PIZ>(arg0, b"PIZ", b"Pizza", b"Pizza for policia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/c14a8ebd-81fd-4e9b-9b68-6a4b1dfe4472")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a3d2298d8d4705f048547da4db2d1c85f767433e62b28572966fec633f2f6b44c9d19598cd8e9ba6f585d563e9d74cc0f21dffaaa0a2eeb1ebabb6238fe32e03f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739103245"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

