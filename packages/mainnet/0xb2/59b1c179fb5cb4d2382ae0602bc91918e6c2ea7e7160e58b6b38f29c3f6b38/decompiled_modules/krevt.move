module 0xb259b1c179fb5cb4d2382ae0602bc91918e6c2ea7e7160e58b6b38f29c3f6b38::krevt {
    struct KREVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KREVT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<KREVT>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<KREVT>(arg0, b"KREVT", b"Krevetes", b"Krevetes ENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYPxj6vcbHP2FQqQUr5NgQjrKyfcZm6M59v2VeGMKBLu2")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00295201f03597818aed15616993e02d972a3f327083cc2ed8d0802858383631ab1c5dd2237a01a928a63923ce34416021ff5e3af52b411352db2b49f0ecc40400f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631740140651"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

