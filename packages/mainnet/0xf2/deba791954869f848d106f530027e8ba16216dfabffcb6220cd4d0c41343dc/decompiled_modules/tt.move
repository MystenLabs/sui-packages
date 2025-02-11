module 0xf2deba791954869f848d106f530027e8ba16216dfabffcb6220cd4d0c41343dc::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TT>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"TOK", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaJ5o41LgaeCiXv8mmNiyNF39SNbDyT3aN9tbAETKbtDC")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0019688adda1feaea0ffafde1a608311be452f8838a7a48a24cba1a2b8ff392780fbae9b43d6f29b42ac5a4b1e27b411a3875e79699794a2055b610ee5600b0003f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739294316"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

