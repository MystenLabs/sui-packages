module 0xb3de334a5ccab3783a0acd00388f0701fad6fd2079d420de518d3cb6df348c3d::bbl {
    struct BBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BBL>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BBL>(arg0, b"BBL", b"Bulbasaur", b"Bulbasaur BBL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcKX9ypiWUNbU59kjUrc4F7pjG42iumoQBxXj8W7i3Hch")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005dc38927d93e6a2893d7772e9194c958873f94c6ecd4beb3400f4f92b0ca5aea3a52cbf9f7a1745bc11139ca1f56f9fc3edea5c0dbc1d0fef11433ef47c2a609f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631740164590"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

