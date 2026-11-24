module 0xc6fe8007b6f4c9a796518a15ea824283c76a74e9cb853b40d4ea07e9dcf39221::sps {
    struct SPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"43719ce41e1de88eb705b92b021689615f46d0e6393f869b35f5ff8c26b73f26")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"43719ce41e1de88eb705b92b021689615f46d0e6393f869b35f5ff8c26b73f26"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SPS>(arg0, 6, 0x1::string::utf8(b"SPS"), 0x1::string::utf8(b"SuperSUI"), 0x1::string::utf8(b"It's just a meme coin in homage to the strength of the Swiss ecosystem."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/962818d948457acb9386fdb9a5163f54fd254a80aa96f510259e078d07ff76a4.webp"), v0, false, 1000, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SPS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SPS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

