module 0xa2d6c8f104ef4837f4fccc70785e3b0e7acd2f5bdf54dc7226c5658e8af89072::qubo {
    struct QUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"2fb1a87b54662c408c181ef38e66d63778fb070230bc8ad9fa5f7250f2ffa670")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"2fb1a87b54662c408c181ef38e66d63778fb070230bc8ad9fa5f7250f2ffa670"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<QUBO>(arg0, 9, 0x1::string::utf8(b"QUBO"), 0x1::string::utf8(b"qubo"), 0x1::string::utf8(b"The qubo coin. qubo.wtf"), 0x1::string::utf8(b"https://qubo.wtf/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<QUBO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<QUBO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

