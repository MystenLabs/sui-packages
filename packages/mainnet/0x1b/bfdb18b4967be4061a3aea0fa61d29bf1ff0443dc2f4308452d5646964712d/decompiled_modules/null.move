module 0x1bbfdb18b4967be4061a3aea0fa61d29bf1ff0443dc2f4308452d5646964712d::null {
    struct NULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NULL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f196862fac2614f85d69c5c99218c1af3edaaccc713c8c41dc604bd6f7238d26")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f196862fac2614f85d69c5c99218c1af3edaaccc713c8c41dc604bd6f7238d26"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NULL>(arg0, 9, 0x1::string::utf8(b"NULL"), 0x1::string::utf8(b"null"), 0x1::string::utf8(b"null"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/0599d6af72b9f9b8ff8881ecfec8130543d1023b3b55787f68c43f57c2e9e46d.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NULL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NULL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

