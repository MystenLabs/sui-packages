module 0x67a6aae175644b945c10f6e321b5ead7b4bfa194a0243ada67379e1617a80506::gpray {
    struct GPRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"33ce4b8c946454ac96afa3a2e11d088c7203e421b10c76cafd86e54436f9fb51")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"33ce4b8c946454ac96afa3a2e11d088c7203e421b10c76cafd86e54436f9fb51"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GPRAY>(arg0, 9, 0x1::string::utf8(b"GPRAY"), 0x1::string::utf8(b"GTA vi Pray"), 0x1::string::utf8(b"Pray every morning"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/644d75ffa9240e1f20a5829a923e8afaca63d1e10138d599b6a1432cff38ee12.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GPRAY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GPRAY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

