module 0x3d61fdeee57db52a9e55cfb1c014823b1048b41c57675fcc14718fa44f30ed8f::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<HOP>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<HOP>(arg0, b"HOP", b"Hip", b"desc test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/b125fe70-982e-4bd4-8ab3-1cd15873cbcf")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d00117876abbe4b58dacc6ae81f23a0e030782f43119549ffc4d31cc5543d4ad07d6e71a50b3c488debedee2cb7d71d757af1f135f292561e1df382790491508f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736973931"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

