module 0x108f90af6ffdd1c56d13d30ba722ff171c473d2626f0a482d58140017e0db4d8::forkpot {
    struct FORKPOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORKPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"20e397d4c7a2d8cb47f51318c0f698d7e004ca75a4fae0157d60cdc024773ab4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"20e397d4c7a2d8cb47f51318c0f698d7e004ca75a4fae0157d60cdc024773ab4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FORKPOT>(arg0, 9, 0x1::string::utf8(b"FORKPOT"), 0x1::string::utf8(b"Forkpot"), 0x1::string::utf8(b"Coins for GitHub repos. forkpot.vercel.app"), 0x1::string::utf8(b"https://forkpot.vercel.app/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FORKPOT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FORKPOT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

