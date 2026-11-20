module 0xc93bc272bf08b49316cad5e66522be75967785155359437d3d9a771dd0391924::planchet {
    struct PLANCHET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANCHET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"5661e5dd1620f58d01bf3509ddad54e93a1b7507b8d5cec2b6828ab5b4dfded1")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"5661e5dd1620f58d01bf3509ddad54e93a1b7507b8d5cec2b6828ab5b4dfded1"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PLANCHET>(arg0, 9, 0x1::string::utf8(b"PLANCHET"), 0x1::string::utf8(b"Planchet"), 0x1::string::utf8(b"Strike a coin. planchet.xyz"), 0x1::string::utf8(b"https://planchet.xyz/brand/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PLANCHET>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PLANCHET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

