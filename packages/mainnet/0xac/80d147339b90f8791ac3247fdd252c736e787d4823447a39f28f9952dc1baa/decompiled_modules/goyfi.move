module 0xac80d147339b90f8791ac3247fdd252c736e787d4823447a39f28f9952dc1baa::goyfi {
    struct GOYFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOYFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"70913c0efb9e2ad2d010ad564781ca8665616ccd9b179f3f7357f3b06f9a8204")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"70913c0efb9e2ad2d010ad564781ca8665616ccd9b179f3f7357f3b06f9a8204"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GOYFI>(arg0, 9, 0x1::string::utf8(b"GOYFI"), 0x1::string::utf8(b"GoyFi"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d672971b0ad1c7d21d81b00cebf2399b82e8cb725b4d80aa4f4131b08cff71ef.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GOYFI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GOYFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

