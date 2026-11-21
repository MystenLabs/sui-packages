module 0x30c5a3c46db5b70497db56058c62caa9261cdeb0d0dd1d8e5ba9ed2754db7d37::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"2a8cb61e0f30c3625f1f62438c7c5e44f25b56ccff2968f188f21b6dcf8981b9")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"2a8cb61e0f30c3625f1f62438c7c5e44f25b56ccff2968f188f21b6dcf8981b9"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NOVA>(arg0, 9, 0x1::string::utf8(b"NOVA"), 0x1::string::utf8(b"NOVACAT"), 0x1::string::utf8(b"NOVACAT didn't come to play. It came to explode. The cosmic cat that eats blasts for breakfast and turns every chart into a supernova. No roadmap. No mercy. Just NOVA."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/43d9c38b75710647850b71e98d623ecc55c535a39e812d7bf456d888bd9d50aa.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NOVA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOVA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

