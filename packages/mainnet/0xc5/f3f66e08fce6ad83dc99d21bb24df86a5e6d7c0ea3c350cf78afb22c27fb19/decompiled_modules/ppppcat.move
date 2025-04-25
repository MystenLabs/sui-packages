module 0xc5f3f66e08fce6ad83dc99d21bb24df86a5e6d7c0ea3c350cf78afb22c27fb19::ppppcat {
    struct PPPPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPPPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<PPPPCAT>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<PPPPCAT>(arg0, b"PpppCAT", b"Cat", b"catsss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2yn8Gvwa2updz5KcTzQJ9uXKaPikKiZnnKMLDX2miC5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d86ca245824c707a19ac08d65f26e67331ddccc40a4814663d2908828c4d013b877f4d36106fcbe29781ecf2521c988c0daa3ee77a82f5894276cb21736afc05f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745590707"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

