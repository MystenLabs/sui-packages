module 0xf523c8dbf2f4f43482ae8e78e7f3f767201408eaca2bb38370b978b7c33646f1::qspd8 {
    struct QSPD8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QSPD8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f4ff8e2c9298ab331d7975b641a0938afda0da1d2fdb0c5f34878bcf492ee686")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f4ff8e2c9298ab331d7975b641a0938afda0da1d2fdb0c5f34878bcf492ee686"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<QSPD8>(arg0, 9, 0x1::string::utf8(b"QSPD8"), 0x1::string::utf8(b"Q Speed Eight"), 0x1::string::utf8(b"speed test 8, do not buy"), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<QSPD8>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<QSPD8>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

