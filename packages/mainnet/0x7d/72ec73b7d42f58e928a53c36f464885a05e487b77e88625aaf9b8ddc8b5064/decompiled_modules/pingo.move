module 0x7d72ec73b7d42f58e928a53c36f464885a05e487b77e88625aaf9b8ddc8b5064::pingo {
    struct PINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"525689626959a4db950b0a241b9b80b1e1e3e05bf0d3ec08e57a94eec8e66b1f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"525689626959a4db950b0a241b9b80b1e1e3e05bf0d3ec08e57a94eec8e66b1f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PINGO>(arg0, 9, 0x1::string::utf8(b"PINGO"), 0x1::string::utf8(b"Pingo"), 0x1::string::utf8(b"Every coin is a blip on the scope. pingo.wtf"), 0x1::string::utf8(b"https://pingo.wtf/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PINGO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PINGO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

