module 0xbfaadbf52c413df8200e584e79f87d1bd1f894fd1b457be92c34b8b12de48f4a::base {
    struct BASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BASE>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BASE>(arg0, b"Base", b"NEW TOKEN", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/QmPMgTcM321C735FUC6LPEhhzu7jVZR8cDjDUNLtrx5Sf8")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001c157a1ae000bdf3d15095415abc8ce57e730e311a6e87744a43231ba017c91eb1357ae7311008fc86d6edd3648fbb8cf88570202a8347a31ebe958a0138c308f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739294008"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

