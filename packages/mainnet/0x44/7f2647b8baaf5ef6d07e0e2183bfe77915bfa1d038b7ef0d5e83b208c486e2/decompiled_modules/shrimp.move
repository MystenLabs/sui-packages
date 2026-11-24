module 0x447f2647b8baaf5ef6d07e0e2183bfe77915bfa1d038b7ef0d5e83b208c486e2::shrimp {
    struct SHRIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SHRIMP>(arg0, 9, 0x1::string::utf8(b"SHRIMP"), 0x1::string::utf8(b"SHRIMP"), 0x1::string::utf8(b"A tiny shrimp with a whale-sized ego. No big wallet, no big brain, just big dreams. Swimming wild on Sui."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/ab66f2ae36de944ad9b344b3fb303d3a3abf904e475a3c8e0f7e6e91d4b39b02.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SHRIMP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SHRIMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

