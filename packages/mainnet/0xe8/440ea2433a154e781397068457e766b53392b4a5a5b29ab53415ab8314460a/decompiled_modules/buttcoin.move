module 0xe8440ea2433a154e781397068457e766b53392b4a5a5b29ab53415ab8314460a::buttcoin {
    struct BUTTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"21e05605c6f19f09bf282986aa68f6b544b1ab187feff522e7c455d8aa084bbb")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"21e05605c6f19f09bf282986aa68f6b544b1ab187feff522e7c455d8aa084bbb"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BUTTCOIN>(arg0, 9, 0x1::string::utf8(b"BUTTCOIN"), 0x1::string::utf8(b"buttcoin"), 0x1::string::utf8(b"Buttcoin is a peer-to-peer butt, means that no central authority issues new butts or tracks butts"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/aecd4c2075d6ed6ebd8ce680a82151228cc380eb41dce6f6f54a696acd4a87c0.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BUTTCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BUTTCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

