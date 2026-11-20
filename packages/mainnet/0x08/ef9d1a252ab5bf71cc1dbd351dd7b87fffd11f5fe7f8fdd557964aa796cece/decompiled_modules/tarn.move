module 0x8ef9d1a252ab5bf71cc1dbd351dd7b87fffd11f5fe7f8fdd557964aa796cece::tarn {
    struct TARN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9f5df12c6780f2fd81966b5d3fd13796238987bfacf8be05f9f55cf0f19b610b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9f5df12c6780f2fd81966b5d3fd13796238987bfacf8be05f9f55cf0f19b610b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TARN>(arg0, 9, 0x1::string::utf8(b"TARN"), 0x1::string::utf8(b"Tarn"), 0x1::string::utf8(b"Presales at the edge of the lake. tarnsakr.xyz"), 0x1::string::utf8(b"https://tarnsakr.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TARN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TARN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

