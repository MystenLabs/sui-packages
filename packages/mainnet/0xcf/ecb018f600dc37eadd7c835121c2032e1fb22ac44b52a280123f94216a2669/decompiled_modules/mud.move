module 0xcfecb018f600dc37eadd7c835121c2032e1fb22ac44b52a280123f94216a2669::mud {
    struct MUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"603d3471f94bc493f5dec9f214d4706da64335a3a22442f84beedb3c23f74a2d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"603d3471f94bc493f5dec9f214d4706da64335a3a22442f84beedb3c23f74a2d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MUD>(arg0, 9, 0x1::string::utf8(b"MUD"), 0x1::string::utf8(b"Mudlark"), 0x1::string::utf8(b"The house coin of Mudlark, the launchpad for digging up coins on Elysium."), 0x1::string::utf8(b"https://mudlark.fun/social/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MUD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MUD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

