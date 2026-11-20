module 0x614a67c9c87a9b9375a9f422513dbe4f90a80ba7b589da746e96c3d06430d51d::bpepe {
    struct BPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"b754821a14173219f473b38463d7da3651fe07cb1df309ed519bc4a4921eebb8")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"b754821a14173219f473b38463d7da3651fe07cb1df309ed519bc4a4921eebb8"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BPEPE>(arg0, 9, 0x1::string::utf8(b"BPEPE"), 0x1::string::utf8(b"Blast Pepe"), 0x1::string::utf8(b"Pepe is the most beloved meme worldwide. Bringing same vibe and energy with a blast"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/ca6830776baba6aa3e6bb2db6b30bd3d07e37ee04f81626a7877184e9ceb7135.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BPEPE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BPEPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

