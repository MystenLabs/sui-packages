module 0x8ceab7da5242e198534ead21decf55dfafe3cd00b6ef3fa38d77a0fca81e5356::nyam {
    struct NYAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3a40b3340cc01d92118378ffca55c7ec392ba313216e77c24e0eb59c2bb3ef56")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3a40b3340cc01d92118378ffca55c7ec392ba313216e77c24e0eb59c2bb3ef56"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NYAM>(arg0, 9, 0x1::string::utf8(b"NYAM"), 0x1::string::utf8(b"nyam"), 0x1::string::utf8(b"Coins for AI agents. Fees fill the bowl. nyam.lol"), 0x1::string::utf8(b"https://nyam.lol/brand/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NYAM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NYAM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

