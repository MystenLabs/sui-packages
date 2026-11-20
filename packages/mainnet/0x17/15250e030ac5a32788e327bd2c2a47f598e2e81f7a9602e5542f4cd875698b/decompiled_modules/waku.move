module 0x1715250e030ac5a32788e327bd2c2a47f598e2e81f7a9602e5542f4cd875698b::waku {
    struct WAKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAKU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"44f345d49e148196368f290c02a323379a086fa32a625e9474d9be0e929f6e21")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"44f345d49e148196368f290c02a323379a086fa32a625e9474d9be0e929f6e21"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<WAKU>(arg0, 9, 0x1::string::utf8(b"WAKU"), 0x1::string::utf8(b"waku"), 0x1::string::utf8(b"Every coin gets a chibi. waku.lol"), 0x1::string::utf8(b"https://waku.lol/brand/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<WAKU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<WAKU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

