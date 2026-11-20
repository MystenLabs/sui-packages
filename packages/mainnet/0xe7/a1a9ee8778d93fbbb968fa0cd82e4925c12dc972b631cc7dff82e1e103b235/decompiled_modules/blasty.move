module 0xe7a1a9ee8778d93fbbb968fa0cd82e4925c12dc972b631cc7dff82e1e103b235::blasty {
    struct BLASTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"545023f65035743e3ecb37e23b67349b92751a27b2fef4f7db6b38530b81529a")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"545023f65035743e3ecb37e23b67349b92751a27b2fef4f7db6b38530b81529a"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLASTY>(arg0, 9, 0x1::string::utf8(b"BLASTY"), 0x1::string::utf8(b"Blasty"), 0x1::string::utf8(b"blast.fun mascot"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/82f81c25be1abff99e84187a1dc74c45d2290472479c3030d62a85a74776db97.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLASTY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLASTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

