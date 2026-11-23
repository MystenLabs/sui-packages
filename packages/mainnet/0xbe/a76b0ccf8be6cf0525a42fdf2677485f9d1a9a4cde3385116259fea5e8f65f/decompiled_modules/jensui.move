module 0xbea76b0ccf8be6cf0525a42fdf2677485f9d1a9a4cde3385116259fea5e8f65f::jensui {
    struct JENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"00e9d67e370037d53ec09976ca27b0c5d3bfb852a4cb0b91c8cb1da3c1e4a97a")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"00e9d67e370037d53ec09976ca27b0c5d3bfb852a4cb0b91c8cb1da3c1e4a97a"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<JENSUI>(arg0, 9, 0x1::string::utf8(b"JENSUI"), 0x1::string::utf8(b"Jensui Huang"), 0x1::string::utf8(b"Leather jacket back on"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/068f7f48ccb7550ab6f70436ac26fa58c528346e30064b91a59764dbd69f2252.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<JENSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<JENSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

