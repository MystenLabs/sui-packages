module 0x4b889fa4ea2b6d394ac390b61238c5e19e372285a9a1fc5e5bd89e285b2ed281::bramble {
    struct BRAMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"103534b34276190dc3aa36c1541d36f3a09f7e7b5487697ecd802d21d9a6515c")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"103534b34276190dc3aa36c1541d36f3a09f7e7b5487697ecd802d21d9a6515c"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BRAMBLE>(arg0, 9, 0x1::string::utf8(b"BRAMBLE"), 0x1::string::utf8(b"Bramble"), 0x1::string::utf8(b"Plant seeds, grow thickets, harvest BRAMBLE. bramble-mauve.vercel.app"), 0x1::string::utf8(b"https://bramble-meta.vercel.app/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BRAMBLE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BRAMBLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

