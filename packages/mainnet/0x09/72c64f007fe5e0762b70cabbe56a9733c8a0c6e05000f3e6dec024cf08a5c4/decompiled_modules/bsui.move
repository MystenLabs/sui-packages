module 0x972c64f007fe5e0762b70cabbe56a9733c8a0c6e05000f3e6dec024cf08a5c4::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"43719ce41e1de88eb705b92b021689615f46d0e6393f869b35f5ff8c26b73f26")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"43719ce41e1de88eb705b92b021689615f46d0e6393f869b35f5ff8c26b73f26"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BSUI>(arg0, 6, 0x1::string::utf8(b"BSUI"), 0x1::string::utf8(b"BabySui"), 0x1::string::utf8(b"Just a memecoin."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/06b82651a5ec37adae2f3120b74b07526b54a2dc8b256fd6061ddbfccb1df497.webp"), v0, false, 200, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

