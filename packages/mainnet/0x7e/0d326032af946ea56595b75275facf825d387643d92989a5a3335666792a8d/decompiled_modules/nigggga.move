module 0x7e0d326032af946ea56595b75275facf825d387643d92989a5a3335666792a8d::nigggga {
    struct NIGGGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"1a29b12a75b0c5b354dd701c870c146b57eaaae1471a97f51ff19a988209290a")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"1a29b12a75b0c5b354dd701c870c146b57eaaae1471a97f51ff19a988209290a"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NIGGGGA>(arg0, 9, 0x1::string::utf8(b"NIGGGGA"), 0x1::string::utf8(b"Chicken & Watermelon"), 0x1::string::utf8(b"https://youtu.be/tRVqVwGWocM?is=ojsK7vvSXZD6SQri"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/62d2eade17ef21a0c5da12b54e6b285f9f5a440ca9acd5f8cec13490104f86c0.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NIGGGGA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NIGGGGA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

