module 0x6d1d489f4509e5974bad7c08334c3cd5f7ed1d71effc1967c8f22ca0554b0713::meep {
    struct MEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9e06771f725faafa7c53e7e6edb2b794e44a67050716916822dae8e5ebdebf95")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9e06771f725faafa7c53e7e6edb2b794e44a67050716916822dae8e5ebdebf95"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MEEP>(arg0, 9, 0x1::string::utf8(b"MEEP"), 0x1::string::utf8(b"MEEP"), 0x1::string::utf8(b"MEEP is here to save the Sui trenches. He cares not of bonding curves or MCAP, only to spread his songs of joy and dominate the world with a cabal of followers that spread his message of peace and subjugation to the MEEP. ALL HAIL MEEP!"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/9dc1b23046ac86f2d9ee456e0b4c6682384c20baa66edbd41c236360f2fa86dc.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MEEP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MEEP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

