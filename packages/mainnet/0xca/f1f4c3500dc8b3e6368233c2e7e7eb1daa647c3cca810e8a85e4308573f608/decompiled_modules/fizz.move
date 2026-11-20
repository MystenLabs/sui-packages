module 0xcaf1f4c3500dc8b3e6368233c2e7e7eb1daa647c3cca810e8a85e4308573f608::fizz {
    struct FIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"18af1f6725767e9a2b05bc42f58e603689c690c53b2a1bdc2a937dce5c549dfe")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"18af1f6725767e9a2b05bc42f58e603689c690c53b2a1bdc2a937dce5c549dfe"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FIZZ>(arg0, 9, 0x1::string::utf8(b"FIZZ"), 0x1::string::utf8(b"fizzpad"), 0x1::string::utf8(b"Pop a coin. fizzpad.fun"), 0x1::string::utf8(b"https://fizzpad.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FIZZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FIZZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

