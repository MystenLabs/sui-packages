module 0x4aa4072933c9d0e3565c0a70e8c310e7332951a36dfe41a39a4ccffab8ce44f6::e25 {
    struct E25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: E25, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"489f1d17288d23dfc35e1e53b6383e1b3af343554d209173a17dac41c286d8f4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"489f1d17288d23dfc35e1e53b6383e1b3af343554d209173a17dac41c286d8f4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<E25>(arg0, 9, 0x1::string::utf8(b"E25"), 0x1::string::utf8(x"d8aed8b1daafd988d8b4"), 0x1::string::utf8(x"d8a7d988d984db8cd98620daa9d988db8cd98620d985d986"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/97b8fcc6b881b48375aa5173c247e948e85963ab0341f335d6a41cd40fb9e3a3.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<E25>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<E25>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

