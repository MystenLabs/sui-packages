module 0xefe5a3a827f61cfc63daf9ca0efbed21ffbcce756a17732a6018fd8b2877720f::sca {
    struct SCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<SCA>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<SCA>(arg0, b"SCA", b"Scalpel", b"This scalpel will slice off any liquidity you have.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/85de7949-38ca-4e85-8278-328d68bdc954")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00fb63a3920f031812f9d0a02b7a39dce6116760219bc4bcb82c16dae07fbb64e2f345ad6629db93d911aed783081c2a26f47da87ee25b6da92470f3b1ef489e00f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737638229"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

