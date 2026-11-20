module 0x7057432968808b0bce2e20295b8924cd409eaea9fd0a926889776ba6d209efa3::shor {
    struct SHOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"729d7c3d2b42391800b248111e0de5442982a75c81b78acc4b136761a758ffda")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"729d7c3d2b42391800b248111e0de5442982a75c81b78acc4b136761a758ffda"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SHOR>(arg0, 9, 0x1::string::utf8(b"SHOR"), 0x1::string::utf8(b"Shorline"), 0x1::string::utf8(b"How exposed is your wallet to a quantum computer. shorline.xyz"), 0x1::string::utf8(b"https://shorline.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SHOR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SHOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

