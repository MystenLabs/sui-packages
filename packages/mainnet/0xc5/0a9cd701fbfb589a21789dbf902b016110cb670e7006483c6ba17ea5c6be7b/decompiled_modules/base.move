module 0xc50a9cd701fbfb589a21789dbf902b016110cb670e7006483c6ba17ea5c6be7b::base {
    struct BASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BASE>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BASE>(arg0, b"Base", b"The", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPMgTcM321C735FUC6LPEhhzu7jVZR8cDjDUNLtrx5Sf8")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0061c644b3ccbad14c94e65b513d16fd0d4729763a14fe6977b71d440e7a70236903edf216c76c4827a1601be2a1a9dec46823238a1209dc0128e0d376dd631904f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739294584"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

