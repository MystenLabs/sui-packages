module 0x29913e920550c42d6f431bcfb4e8f3faaf70d4458a2ed590fe203eb27cf2aa92::vqb5 {
    struct VQB5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VQB5, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4f0c7c641aa7f8fa59043fcd31bda5191da50fd12b6aec54a544c35605b05c3f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4f0c7c641aa7f8fa59043fcd31bda5191da50fd12b6aec54a544c35605b05c3f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<VQB5>(arg0, 9, 0x1::string::utf8(b"VQB5"), 0x1::string::utf8(b"Viper QA VQB5"), 0x1::string::utf8(b"Viper Terminal engine test. Test coin, do not buy."), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<VQB5>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<VQB5>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

