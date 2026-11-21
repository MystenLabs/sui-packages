module 0x7029bbecf43f477e048a92d6dd23bf24fba039228539ddb71b727847e7b65633::baro {
    struct BARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"53f1d2dea06e9645b9dd68671433e65b0e193416e7df83eada9c238902b3b69e")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"53f1d2dea06e9645b9dd68671433e65b0e193416e7df83eada9c238902b3b69e"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BARO>(arg0, 9, 0x1::string::utf8(b"BARO"), 0x1::string::utf8(b"Barogram"), 0x1::string::utf8(b"Every coin starts calm. barogram.xyz"), 0x1::string::utf8(b"https://barogram.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BARO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BARO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

