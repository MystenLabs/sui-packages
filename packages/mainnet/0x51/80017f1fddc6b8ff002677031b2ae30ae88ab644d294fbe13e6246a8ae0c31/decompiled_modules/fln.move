module 0x5180017f1fddc6b8ff002677031b2ae30ae88ab644d294fbe13e6246a8ae0c31::fln {
    struct FLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"138f93783f19361a8303180faa05437d87f6a09a9446eafa8f9d9eea0d6f0f9f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"138f93783f19361a8303180faa05437d87f6a09a9446eafa8f9d9eea0d6f0f9f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FLN>(arg0, 9, 0x1::string::utf8(b"FLN"), 0x1::string::utf8(b"Falcon"), 0x1::string::utf8(b"A digital token built to empower decentralized financial applications"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/bec21b9ea51812c5d5f709e6d7a4879d53815b9d819284194361c865dcaa818f.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FLN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FLN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

