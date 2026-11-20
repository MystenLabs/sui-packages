module 0xe4029e8f032e797fea79b54f4b26973d75ebd1e40255b6cf3ea609f5494d180e::qspd3 {
    struct QSPD3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QSPD3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f4ff8e2c9298ab331d7975b641a0938afda0da1d2fdb0c5f34878bcf492ee686")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f4ff8e2c9298ab331d7975b641a0938afda0da1d2fdb0c5f34878bcf492ee686"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<QSPD3>(arg0, 9, 0x1::string::utf8(b"QSPD3"), 0x1::string::utf8(b"Q Speed Three"), 0x1::string::utf8(b"speed test 3, do not buy"), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<QSPD3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<QSPD3>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

