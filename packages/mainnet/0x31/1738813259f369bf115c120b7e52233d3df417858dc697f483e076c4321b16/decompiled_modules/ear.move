module 0x311738813259f369bf115c120b7e52233d3df417858dc697f483e076c4321b16::ear {
    struct EAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<EAR>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<EAR>(arg0, b"EAR", b"Planet Earth", b"Earth is the third planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"https://en.wikipedia.org/wiki/Earth", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002dca839e79a6b908ef50942bfbc6ebfc026fe1f4b0da403b05c103e977468ea8301050bc206f6883c1579abec0f796d1514cfe4876ccbbd4d7f23d22506ef804f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745921044"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

