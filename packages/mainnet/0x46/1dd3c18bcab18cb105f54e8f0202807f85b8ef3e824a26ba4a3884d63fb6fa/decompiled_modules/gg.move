module 0x461dd3c18bcab18cb105f54e8f0202807f85b8ef3e824a26ba4a3884d63fb6fa::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a03a457a50c9fef8fc1fa4985dea21434b945bb5942085099afa4052f861f318")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a03a457a50c9fef8fc1fa4985dea21434b945bb5942085099afa4052f861f318"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GG>(arg0, 6, 0x1::string::utf8(b"GG"), 0x1::string::utf8(b"gg"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/27e2996c83b64280435b86c0c7852f4eeea57d0b57a4c0f3ed2b021911a52778.webp"), v0, false, 1000, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

