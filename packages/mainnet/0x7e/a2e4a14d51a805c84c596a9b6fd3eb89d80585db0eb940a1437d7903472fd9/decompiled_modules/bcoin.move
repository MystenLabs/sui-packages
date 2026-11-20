module 0x7ea2e4a14d51a805c84c596a9b6fd3eb89d80585db0eb940a1437d7903472fd9::bcoin {
    struct BCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4ade30af851559af7ec3f1203298e0eb7dc0a1b650e4bf3bae53a7670800b9ae")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4ade30af851559af7ec3f1203298e0eb7dc0a1b650e4bf3bae53a7670800b9ae"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BCOIN>(arg0, 9, 0x1::string::utf8(b"BCOIN"), 0x1::string::utf8(b"blast coin"), 0x1::string::utf8(b"blast coin"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/7624261f0373da6e363fc356b1296c82f07d72c13b0bc7d442b98b5bfee9dbb6.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

