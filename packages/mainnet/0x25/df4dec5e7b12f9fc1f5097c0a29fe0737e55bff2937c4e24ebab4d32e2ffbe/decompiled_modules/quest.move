module 0x25df4dec5e7b12f9fc1f5097c0a29fe0737e55bff2937c4e24ebab4d32e2ffbe::quest {
    struct QUEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e071cd365ffc308333f3e17011d9d059f1bd6e296dd9342a57ae5410011d9b22")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e071cd365ffc308333f3e17011d9d059f1bd6e296dd9342a57ae5410011d9b22"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<QUEST>(arg0, 9, 0x1::string::utf8(b"QUEST"), 0x1::string::utf8(b"LIND"), 0x1::string::utf8(b"lind is going on a quest Bundled launch: the creator also buys through 4 other wallets at launch."), 0x1::string::utf8(b"https://viper-terminal.app/api/coin-icon/1dc81a658e0fbe95e0e320376ce3429b560bf66d64b87dabe0adbe2a8c433f09.png"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<QUEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<QUEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

