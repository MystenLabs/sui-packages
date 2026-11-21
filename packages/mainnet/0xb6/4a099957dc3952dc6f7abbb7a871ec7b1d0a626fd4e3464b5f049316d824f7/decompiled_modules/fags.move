module 0xb64a099957dc3952dc6f7abbb7a871ec7b1d0a626fd4e3464b5f049316d824f7::fags {
    struct FAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"777f2bd28a394178f9809afa019945169c6c463319d8960d5c38dccf0242720c")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"777f2bd28a394178f9809afa019945169c6c463319d8960d5c38dccf0242720c"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FAGS>(arg0, 9, 0x1::string::utf8(b"FAGS"), 0x1::string::utf8(b"Mysten Fags"), 0x1::string::utf8(x"416e796f6e6520656c736520626f726564206f66207468652062756c6c736869742066726f6d204d797374656e2046616773e280a62e204c696b65204d696b65205479736f6e2073616964e280a62e2049e280996d6d6120465544207468656d2074696c6c2074686579206c6f7665206d65"), 0x1::string::utf8(b"https://viper-terminal.app/api/coin-icon/8a361ddc90f0fce35c361e505a092e1dcb8bdda95f65da9acec0298c3b3651a9.png"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FAGS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FAGS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

