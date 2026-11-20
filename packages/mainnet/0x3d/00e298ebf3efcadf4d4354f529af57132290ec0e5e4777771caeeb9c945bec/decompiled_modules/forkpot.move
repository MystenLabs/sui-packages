module 0x3d00e298ebf3efcadf4d4354f529af57132290ec0e5e4777771caeeb9c945bec::forkpot {
    struct FORKPOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORKPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"ae608c9813eb6979e3ab200cff53ea5ccb80c533493fb4d9ce7e7b3aef9aff8c")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"ae608c9813eb6979e3ab200cff53ea5ccb80c533493fb4d9ce7e7b3aef9aff8c"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FORKPOT>(arg0, 9, 0x1::string::utf8(b"FORKPOT"), 0x1::string::utf8(b"Forkpot"), 0x1::string::utf8(b"Coins for GitHub repos. forkpot.vercel.app"), 0x1::string::utf8(b"https://forkpot.vercel.app/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FORKPOT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FORKPOT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

