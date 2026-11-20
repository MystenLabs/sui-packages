module 0xb2581a01819b56b55000b70571d52fd106774fc608452a4e9e02a25a2d06b627::dcty {
    struct DCTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"07c8c26b8be29eb4f21f1ef863b0802ac3448252528283aa1ddc733dfd6d7218")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"07c8c26b8be29eb4f21f1ef863b0802ac3448252528283aa1ddc733dfd6d7218"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<DCTY>(arg0, 9, 0x1::string::utf8(b"DCTY"), 0x1::string::utf8(b"DacityCoin"), 0x1::string::utf8(b"Dacity on Blast."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/82cd1f9e935278960bedcc0a0cbfa5cd69bb9ea35d7e8b8db6d6311ede6d119c.webp"), v0, true, 5000, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<DCTY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DCTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

