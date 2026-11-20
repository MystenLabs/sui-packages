module 0xd8388ce5d19bf85119386c822ea136eef8db8c6907d7442d832e081416dd0ecf::dotcom {
    struct DOTCOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTCOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a714206ac3ec2b16f4a476064aabe4c3fa2db2f5c6576a0b5d2b1e8034eafa7f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a714206ac3ec2b16f4a476064aabe4c3fa2db2f5c6576a0b5d2b1e8034eafa7f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<DOTCOM>(arg0, 9, 0x1::string::utf8(b"DOTCOM"), 0x1::string::utf8(b"dotcom"), 0x1::string::utf8(b"dotcom"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/c28c47fdd6ccd258c0c939e3b2f3ab9ad1e8d6c48d48b441fd106bc1f4615ee0.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<DOTCOM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DOTCOM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

