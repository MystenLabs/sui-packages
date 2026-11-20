module 0xf5aca50caeb4b140aff1e8bcadb593b49b250f650ae5ce3ba71f2f12d5f8c9a4::bluefin {
    struct BLUEFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"87344d7f233a68dc8be9652918e4c8641e1c22736550d458d7a62f2137df2292")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"87344d7f233a68dc8be9652918e4c8641e1c22736550d458d7a62f2137df2292"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLUEFIN>(arg0, 6, 0x1::string::utf8(b"BLUEFIN"), 0x1::string::utf8(b"Bluefin"), 0x1::string::utf8(b"Bluefin"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/13f838a18746cf002541df163efa16b51649b92a60fac4289c5be686290d169e.webp"), v0, true, 2000, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLUEFIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLUEFIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

