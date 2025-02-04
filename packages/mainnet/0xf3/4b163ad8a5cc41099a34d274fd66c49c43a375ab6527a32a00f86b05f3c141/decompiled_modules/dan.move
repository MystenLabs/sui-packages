module 0xf34b163ad8a5cc41099a34d274fd66c49c43a375ab6527a32a00f86b05f3c141::dan {
    struct DAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<DAN>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<DAN>(arg0, b"DAN", b"Dandelion", b"Dandelion s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/fd0497bf-b054-428d-858e-acdf85962bef")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005a95e4e6b383eb0edf6f9720d9ff25720081777f01e17a61082e73e37f292b3aecf3c537e4c1efd2707ea9f40f66f9e47fcbedf81fb145ebc5ef3601b66fc909f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738667592"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

