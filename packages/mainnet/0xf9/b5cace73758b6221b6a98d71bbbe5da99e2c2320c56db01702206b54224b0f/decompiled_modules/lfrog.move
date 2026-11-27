module 0xf9b5cace73758b6221b6a98d71bbbe5da99e2c2320c56db01702206b54224b0f::lfrog {
    struct LFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a2c602d5fdf42f709e0877c0f7a2dc515e9090edd9b2994c346d067178648b2b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a2c602d5fdf42f709e0877c0f7a2dc515e9090edd9b2994c346d067178648b2b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LFROG>(arg0, 9, 0x1::string::utf8(b"LFROG"), 0x1::string::utf8(b"Liquid Frog"), 0x1::string::utf8(x"426f726e20696e207468652064656570657374204859504520706f6f6c73206f6620456c797369756d0a546865206d6f7374206c697175696420616d7068696269616e206f6e636861696e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/2e26e890746c34f5c9a7e3d1cc596ff02457cb79245e041ff04fdff6dfbc4509.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LFROG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LFROG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

