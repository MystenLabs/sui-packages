module 0x9a36e95f733b21dd0559c31a30f7df2c42beb08b587e4017c878bb76f7457dbc::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"93ec190b8f9641b9291e8c89880efef98e1de3de3796fc883e77c2d48aefb05f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"93ec190b8f9641b9291e8c89880efef98e1de3de3796fc883e77c2d48aefb05f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HONEY>(arg0, 9, 0x1::string::utf8(b"HONEY"), 0x1::string::utf8(b"Honeyframe"), 0x1::string::utf8(b"Presales that fill like a honeycomb. honeyframe.xyz"), 0x1::string::utf8(b"https://honeyframe.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HONEY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HONEY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

