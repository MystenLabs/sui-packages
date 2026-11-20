module 0x7be0bd03ba0a82b8c78e6554459a0d31b3626603952e090e9dc19c6ae738efa9::tesera {
    struct TESERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESERA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"70913c0efb9e2ad2d010ad564781ca8665616ccd9b179f3f7357f3b06f9a8204")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"70913c0efb9e2ad2d010ad564781ca8665616ccd9b179f3f7357f3b06f9a8204"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TESERA>(arg0, 9, 0x1::string::utf8(b"TESERA"), 0x1::string::utf8(b"Tesera Lab"), 0x1::string::utf8(b"On-Chain Infrastructure for AI Agents."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/fff984d32956459c4d9b590829d0cb93bdefcd96dc7372e69aa84e3f3072ea0a.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TESERA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TESERA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

