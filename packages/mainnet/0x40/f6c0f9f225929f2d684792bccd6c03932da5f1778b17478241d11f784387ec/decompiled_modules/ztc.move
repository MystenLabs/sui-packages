module 0x40f6c0f9f225929f2d684792bccd6c03932da5f1778b17478241d11f784387ec::ztc {
    struct ZTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"b715813ae41985c10a128de06d36ecba1913f107ec3cd13731567bb05640f383")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"b715813ae41985c10a128de06d36ecba1913f107ec3cd13731567bb05640f383"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ZTC>(arg0, 9, 0x1::string::utf8(b"ZTC"), 0x1::string::utf8(b"Zeta Test C"), 0x1::string::utf8(b"internal rehearsal coin, TEST_SUI only, no value"), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ZTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ZTC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

