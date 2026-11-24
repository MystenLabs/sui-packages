module 0x6fc211ae7805eb158f12a3f1387e9216bc1a04544a9f0754ff8c1346189a08ce::vqb1 {
    struct VQB1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VQB1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4f0c7c641aa7f8fa59043fcd31bda5191da50fd12b6aec54a544c35605b05c3f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4f0c7c641aa7f8fa59043fcd31bda5191da50fd12b6aec54a544c35605b05c3f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<VQB1>(arg0, 9, 0x1::string::utf8(b"VQB1"), 0x1::string::utf8(b"Viper QA VQB1"), 0x1::string::utf8(b"Viper Terminal engine test (TEST_SUI). Not a real coin."), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<VQB1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<VQB1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

