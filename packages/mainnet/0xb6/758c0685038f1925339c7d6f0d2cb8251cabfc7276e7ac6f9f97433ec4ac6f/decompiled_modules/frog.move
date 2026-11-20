module 0xb6758c0685038f1925339c7d6f0d2cb8251cabfc7276e7ac6f9f97433ec4ac6f::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e044761261398d4bfa7af5e19ead77c5426bc63a93dcf99e52cdecf0213ab1ed")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e044761261398d4bfa7af5e19ead77c5426bc63a93dcf99e52cdecf0213ab1ed"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FROG>(arg0, 9, 0x1::string::utf8(b"FROG"), 0x1::string::utf8(b"Blast Frog"), 0x1::string::utf8(b"The most Unique meme out of Blast ecosystem. Join the community join the movement. Robbit."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/30de0d44ce1944a6130b0fd723ff04025c3ea3b9e310b96b1c8640804f4c3016.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FROG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FROG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

