module 0xd3ea5a01c0d4b33c7631d79c6e58a65314050b83ad29afdd5e5d5a5a2eb785c3::fizz {
    struct FIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"32d2f73877275c6740a16b723f8a22940b5028ff54d3dc987f44f411ac18d401")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"32d2f73877275c6740a16b723f8a22940b5028ff54d3dc987f44f411ac18d401"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FIZZ>(arg0, 9, 0x1::string::utf8(b"FIZZ"), 0x1::string::utf8(b"fizzpad"), 0x1::string::utf8(b"Pop a coin. fizzpad.fun"), 0x1::string::utf8(b"https://fizzpad.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FIZZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FIZZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

