module 0x473bb5283f1de2f98edb4b18347aa7c7bf3d08017a8825d1b344ecc653ff39be::zta {
    struct ZTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"b715813ae41985c10a128de06d36ecba1913f107ec3cd13731567bb05640f383")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"b715813ae41985c10a128de06d36ecba1913f107ec3cd13731567bb05640f383"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ZTA>(arg0, 9, 0x1::string::utf8(b"ZTA"), 0x1::string::utf8(b"Zeta Test A"), 0x1::string::utf8(b"internal rehearsal coin, TEST_SUI only, no value"), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ZTA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ZTA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

