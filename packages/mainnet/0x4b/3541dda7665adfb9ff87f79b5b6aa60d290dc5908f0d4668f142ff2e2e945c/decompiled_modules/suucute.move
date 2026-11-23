module 0x4b3541dda7665adfb9ff87f79b5b6aa60d290dc5908f0d4668f142ff2e2e945c::suucute {
    struct SUUCUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUCUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"1a6233550489251672f239c6fe6c3f1101da01be9977d0ad671bfd3354aeec2b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"1a6233550489251672f239c6fe6c3f1101da01be9977d0ad671bfd3354aeec2b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SUUCUTE>(arg0, 9, 0x1::string::utf8(b"SUUCUTE"), 0x1::string::utf8(b"sui mooni"), 0x1::string::utf8(b"its simple of suuii"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a0108ae841f975810ddb0375f0ca6fa26cd786e0736aa9c25f93064f38a09420.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SUUCUTE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SUUCUTE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

