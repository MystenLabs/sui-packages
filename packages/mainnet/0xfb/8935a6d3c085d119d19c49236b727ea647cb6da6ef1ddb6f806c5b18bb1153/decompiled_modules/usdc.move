module 0xfb8935a6d3c085d119d19c49236b727ea647cb6da6ef1ddb6f806c5b18bb1153::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"21e05605c6f19f09bf282986aa68f6b544b1ab187feff522e7c455d8aa084bbb")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"21e05605c6f19f09bf282986aa68f6b544b1ab187feff522e7c455d8aa084bbb"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<USDC>(arg0, 9, 0x1::string::utf8(b"USDC"), 0x1::string::utf8(b"united states debt coin"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/2c312610e495fc604ca673c8eaa8d0e287e616c47c806c24691805ed810aed19.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<USDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<USDC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

