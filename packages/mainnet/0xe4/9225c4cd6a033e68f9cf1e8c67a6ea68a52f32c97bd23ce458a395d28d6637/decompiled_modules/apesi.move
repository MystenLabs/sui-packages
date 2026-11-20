module 0xe49225c4cd6a033e68f9cf1e8c67a6ea68a52f32c97bd23ce458a395d28d6637::apesi {
    struct APESI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APESI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"fda6b15fe1bd5084567469a9f03499da2787c563fb1cd1aa6d29cc162c6f7576")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"fda6b15fe1bd5084567469a9f03499da2787c563fb1cd1aa6d29cc162c6f7576"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<APESI>(arg0, 9, 0x1::string::utf8(b"APESI"), 0x1::string::utf8(b"ApeSuperint"), 0x1::string::utf8(b"Automated Bot"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/493e7566fd331345abd3ccd0408519272b35ec22a6c80c20908a30028db68fdc.webp"), v0, true, 50, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<APESI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<APESI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

