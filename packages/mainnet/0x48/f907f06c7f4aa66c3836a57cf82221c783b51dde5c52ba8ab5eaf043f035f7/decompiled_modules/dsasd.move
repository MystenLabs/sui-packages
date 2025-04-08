module 0x48f907f06c7f4aa66c3836a57cf82221c783b51dde5c52ba8ab5eaf043f035f7::dsasd {
    struct DSASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSASD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DSASD>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DSASD>(arg0, b"DSASD", b"DASD", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00aaab325668c665ba42b1008ceae2e4bf01bac3496d6d2ebc891affd6b62cefa4231f31e9b720915406a90f46a8d50083161c8be05bc057b9bd818ef62abe570cf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744112761"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

