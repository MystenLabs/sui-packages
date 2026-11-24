module 0xe63bea97840d006203c0bf9b33185d64f50be6a532ab913ec3475d7def5a78ec::skill {
    struct SKILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKILL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SKILL>(arg0, 9, 0x1::string::utf8(b"SKILL"), 0x1::string::utf8(b"SKILL"), 0x1::string::utf8(x"4e6f207761726e696e67732e204e6f206e6f6973652e204a75737420657865637574696f6e2e0a54686520717569657465737420746872656174206f6e205375690a5061797320686f6c646572732e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/7cf72e5f1df2afee3f672334990cd31627c8befa05cfa8667caeaf4b08b4130b.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SKILL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SKILL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

