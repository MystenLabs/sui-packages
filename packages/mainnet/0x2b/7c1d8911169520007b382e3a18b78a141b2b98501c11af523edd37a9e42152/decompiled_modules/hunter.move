module 0x2b7c1d8911169520007b382e3a18b78a141b2b98501c11af523edd37a9e42152::hunter {
    struct HUNTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<HUNTER>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<HUNTER>(arg0, b"HUNTER", b"HISOKO", b"Clown hunter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmefH5ParXM3VBuH1pZsBepeo1GVLZkbKxoaq74VcfwuDY")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00eb50364efccdc8bb3048ea5125949198809c00b31de536cd082353726151b6ceff0e9262795784ee93f280707417fb18e64a4aa662b28f869402f6157fdf870bf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743420527"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

