module 0xab7c94f731df6173b95b9ec10de762818db0a882e58af1bb728d0a3a900431c9::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"70913c0efb9e2ad2d010ad564781ca8665616ccd9b179f3f7357f3b06f9a8204")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"70913c0efb9e2ad2d010ad564781ca8665616ccd9b179f3f7357f3b06f9a8204"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BCAT>(arg0, 9, 0x1::string::utf8(b"BCAT"), 0x1::string::utf8(b"BlastCat"), 0x1::string::utf8(x"54686520636f6f6c65737420636174206f6e20426c6173742e20f09f9088e2808de2ac9b"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/445998fa506f974b3a46fcc6fe0f96e4de8275092ea78ff347636587c5d0badf.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BCAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

