module 0x4e4a3e4291bbb87bc78f64ff748a30a89ebad47b6d30b38ec93b8106eb866222::testt {
    struct TESTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TESTT>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TESTT>(arg0, b"TESTT", b"TokenWW", b"check", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfHhjh1ZSuvTdwC5DUEHe1EBa1v1kd3FwpuQp4Q8sLY76")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003dc7ddb86dac2c7ffc584be0ddf6ede30ae448cd92253fd88f25ad5b6ea0a5c56e13cab1f028fea5fb87cc3ae7f2cff138aab6dc9d8fb1324c0fb8a33cb12209f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744013702"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

