module 0x1e2cfd06379e5cdfcda892240e496ee79d0d573f150ea45e5dcbdebe9301f603::peps {
    struct PEPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"60311dee7a50357dc074bb440492206f3fcf7f9b3c0f50ee43ea6f8ad7c8950a")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"60311dee7a50357dc074bb440492206f3fcf7f9b3c0f50ee43ea6f8ad7c8950a"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PEPS>(arg0, 9, 0x1::string::utf8(b"PEPS"), 0x1::string::utf8(b"Pepe sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b123f84aabcf604213a1beafa0215d21f7937cf8e4f07c73ee2815e0ba32424a.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PEPS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PEPS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

