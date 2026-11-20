module 0x3993f3f0a63860f5e84db4d08e4b5764cd411b44bc032856dea2bb88615d69b9::nigga {
    struct NIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"33ce4b8c946454ac96afa3a2e11d088c7203e421b10c76cafd86e54436f9fb51")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"33ce4b8c946454ac96afa3a2e11d088c7203e421b10c76cafd86e54436f9fb51"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NIGGA>(arg0, 9, 0x1::string::utf8(b"NIGGA"), 0x1::string::utf8(b"Nigga"), 0x1::string::utf8(b"It's over nigga time to move to tiktok"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a7e1b1d4a60705ddc568f611bacc07b7a4449014de20fbd8deb1b2569ab65f17.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NIGGA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NIGGA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

