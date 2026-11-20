module 0xd95e924bf2d760bee537b2ae04508f9409e36005625148f11016b57138e7b100::slip {
    struct SLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"6be19ea9b212c1d8aa00eb96703f2f06e9c400f252037fae04f511b2dffe2a0f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"6be19ea9b212c1d8aa00eb96703f2f06e9c400f252037fae04f511b2dffe2a0f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SLIP>(arg0, 9, 0x1::string::utf8(b"SLIP"), 0x1::string::utf8(b"Slipbook"), 0x1::string::utf8(b"Get in before the pool fills up. slipbook.xyz"), 0x1::string::utf8(b"https://slipbook.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SLIP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SLIP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

