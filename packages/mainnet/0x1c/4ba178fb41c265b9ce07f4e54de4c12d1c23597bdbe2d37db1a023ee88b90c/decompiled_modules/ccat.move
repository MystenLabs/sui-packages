module 0x1c4ba178fb41c265b9ce07f4e54de4c12d1c23597bdbe2d37db1a023ee88b90c::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"5011f9e14d58df66bcaa6033f4e4058190824302fca65ddf4db0e2dc270538a4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"5011f9e14d58df66bcaa6033f4e4058190824302fca65ddf4db0e2dc270538a4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CCAT>(arg0, 9, 0x1::string::utf8(b"CCAT"), 0x1::string::utf8(b"Crown Cat"), 0x1::string::utf8(b"The royal cat of the meme universe. Built for fun and community."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/adafa02480fc3c64f43a5f79dcc89ca858beb736b84247c531c48c8d51920a1b.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CCAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

