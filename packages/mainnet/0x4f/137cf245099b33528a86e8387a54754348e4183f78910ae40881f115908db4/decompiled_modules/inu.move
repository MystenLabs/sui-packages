module 0x4f137cf245099b33528a86e8387a54754348e4183f78910ae40881f115908db4::inu {
    struct INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: INU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"d2b6d11dd09ef4f79585333f69930f6df11cd19be955adaa043e6093f225e9b2")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"d2b6d11dd09ef4f79585333f69930f6df11cd19be955adaa043e6093f225e9b2"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<INU>(arg0, 9, 0x1::string::utf8(b"INU"), 0x1::string::utf8(b"Blast Inu"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/1d2bdfbc8b94b906c5f4bff53924f5da4abcfd694f193b2bc853fa654374162d.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<INU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<INU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

