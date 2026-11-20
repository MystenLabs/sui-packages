module 0x179f4a71b09c3085ee06e8644e89849760c2c62d646b9066a49fc3508d35b2d8::crumb {
    struct CRUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"722f98458c3a28700f8e8aa94d111bdc2026a85b8b15f222eb8055f5265adea7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"722f98458c3a28700f8e8aa94d111bdc2026a85b8b15f222eb8055f5265adea7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CRUMB>(arg0, 9, 0x1::string::utf8(b"CRUMB"), 0x1::string::utf8(b"Crumb"), 0x1::string::utf8(b"One city pigeon, one whole sandwich. crumbe.xyz"), 0x1::string::utf8(b"https://crumbe.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CRUMB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CRUMB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

