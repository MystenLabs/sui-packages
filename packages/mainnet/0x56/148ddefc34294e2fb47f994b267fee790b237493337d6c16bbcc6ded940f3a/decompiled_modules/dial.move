module 0x56148ddefc34294e2fb47f994b267fee790b237493337d6c16bbcc6ded940f3a::dial {
    struct DIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"edb325b52103390ba85f598d83392b97bd6cbcc88bb20ac3d11e67745859df58")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"edb325b52103390ba85f598d83392b97bd6cbcc88bb20ac3d11e67745859df58"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<DIAL>(arg0, 9, 0x1::string::utf8(b"DIAL"), 0x1::string::utf8(b"Dropdial"), 0x1::string::utf8(b"Coin launches on a falling auction clock. dropdial.fun"), 0x1::string::utf8(b"https://dropdial.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<DIAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DIAL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

