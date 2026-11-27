module 0xf1222b0cb8635b5c40a5121e421bcaefce02e9bdeed12a41fc93e2162de72352::mrkt {
    struct MRKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRKT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a8d2d0736b53127ac9e8dc9189430eb827ae32a0270a6ddbd60339825310eee9")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a8d2d0736b53127ac9e8dc9189430eb827ae32a0270a6ddbd60339825310eee9"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MRKT>(arg0, 6, 0x1::string::utf8(b"MRKT"), 0x1::string::utf8(b"MARKET"), 0x1::string::utf8(b"Bundled launch: the creator also buys through 2 other wallets at launch."), 0x1::string::utf8(b"https://viper-terminal.app/api/coin-icon/63c71290fea0765a0d17872620a7de74d77f858588089ae349ebc410fd270c2e.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MRKT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MRKT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

