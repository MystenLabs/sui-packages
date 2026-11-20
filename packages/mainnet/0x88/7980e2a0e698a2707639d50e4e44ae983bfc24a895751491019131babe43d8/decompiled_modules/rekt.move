module 0x887980e2a0e698a2707639d50e4e44ae983bfc24a895751491019131babe43d8::rekt {
    struct REKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REKT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9f0209e6dff2a15350979a561bececcf850a6f88eeb4b760b0b2796b3aa2301c")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9f0209e6dff2a15350979a561bececcf850a6f88eeb4b760b0b2796b3aa2301c"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<REKT>(arg0, 9, 0x1::string::utf8(b"REKT"), 0x1::string::utf8(b"Rekt"), 0x1::string::utf8(b"get Rekt!"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/3cdd9a31fe07850e2280b6c37be23f779ec7e8d823e061ef7f77eecd0e7e827f.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<REKT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<REKT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

