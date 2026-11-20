module 0x14790e33c866003eeacf213486a279d6c69f789a98c05c5d1cacfbedd85f4b20::safelight {
    struct SAFELIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFELIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"bfa13f86c83e61ed9cd458b173cbc49b5ceea1df2b74adecfed9399db78d8c1c")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"bfa13f86c83e61ed9cd458b173cbc49b5ceea1df2b74adecfed9399db78d8c1c"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SAFELIGHT>(arg0, 9, 0x1::string::utf8(b"SAFELIGHT"), 0x1::string::utf8(b"Safelight"), 0x1::string::utf8(b"Coins develop like prints as the pool fills. safelight.fun"), 0x1::string::utf8(b"https://safelight.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SAFELIGHT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SAFELIGHT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

