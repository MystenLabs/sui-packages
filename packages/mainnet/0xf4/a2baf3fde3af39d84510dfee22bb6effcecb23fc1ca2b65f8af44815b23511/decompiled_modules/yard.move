module 0xf4a2baf3fde3af39d84510dfee22bb6effcecb23fc1ca2b65f8af44815b23511::yard {
    struct YARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"1dcc0d77e608a283c94e3a988b8024059eb6df7fd53c6ea2f6bcd88a22864a45")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"1dcc0d77e608a283c94e3a988b8024059eb6df7fd53c6ea2f6bcd88a22864a45"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<YARD>(arg0, 9, 0x1::string::utf8(b"YARD"), 0x1::string::utf8(b"Switchyard"), 0x1::string::utf8(b"Every coin gets switched onto its own track. switchyardpad.xyz"), 0x1::string::utf8(b"https://switchyardpad.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<YARD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<YARD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

