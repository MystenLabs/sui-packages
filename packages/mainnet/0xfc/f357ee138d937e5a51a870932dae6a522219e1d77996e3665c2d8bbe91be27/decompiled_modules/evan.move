module 0xfcf357ee138d937e5a51a870932dae6a522219e1d77996e3665c2d8bbe91be27::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"489e7b801fa43b8ba11038733e3909d3cdd6db3c21bd0e80dc9704f77c148f7d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"489e7b801fa43b8ba11038733e3909d3cdd6db3c21bd0e80dc9704f77c148f7d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<EVAN>(arg0, 9, 0x1::string::utf8(b"EVAN"), 0x1::string::utf8(b"Evan Coin creator"), 0x1::string::utf8(b"Evan Coin creator ($EVAN) deployed on Blast.fun via OurBlast. | Deploy: https://x.com/Grxxxkun/status/2125386556131418486 | X: https://x.com/Grxxxkun"), 0x1::string::utf8(b"https://pbs.twimg.com/media/HX7jzotbsAAzsVf.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<EVAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<EVAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

