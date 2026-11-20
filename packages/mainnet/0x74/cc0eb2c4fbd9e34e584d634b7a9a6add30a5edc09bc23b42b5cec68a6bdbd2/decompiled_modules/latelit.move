module 0x74cc0eb2c4fbd9e34e584d634b7a9a6add30a5edc09bc23b42b5cec68a6bdbd2::latelit {
    struct LATELIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LATELIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"972892e8cb4f26fabe00519bfd4352fdc680ed94b9f8366933ed1f41497375aa")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"972892e8cb4f26fabe00519bfd4352fdc680ed94b9f8366933ed1f41497375aa"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LATELIT>(arg0, 9, 0x1::string::utf8(b"LATELIT"), 0x1::string::utf8(b"Latelit"), 0x1::string::utf8(b"A city block where every coin gets a window. Buys keep the lights on. latelit.xyz"), 0x1::string::utf8(b"https://latelit.xyz/brand/pp-512.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LATELIT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LATELIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

