module 0xc2f838459aab1cbd0eb7bc5c7a8b6587a74b7ba786ec47fa3bbf237f7e2a8d9::safelight {
    struct SAFELIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFELIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f35479da28ac824b3b5c5fb82eaa78214e82f6d7780b216f59b829a4dbf087c3")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f35479da28ac824b3b5c5fb82eaa78214e82f6d7780b216f59b829a4dbf087c3"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SAFELIGHT>(arg0, 9, 0x1::string::utf8(b"SAFELIGHT"), 0x1::string::utf8(b"Safelight"), 0x1::string::utf8(b"Coins develop like prints as the pool fills. safelight.fun"), 0x1::string::utf8(b"https://safelight.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SAFELIGHT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SAFELIGHT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

