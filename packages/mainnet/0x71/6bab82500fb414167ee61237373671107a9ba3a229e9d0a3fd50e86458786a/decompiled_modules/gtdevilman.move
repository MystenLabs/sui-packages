module 0x716bab82500fb414167ee61237373671107a9ba3a229e9d0a3fd50e86458786a::gtdevilman {
    struct GTDEVILMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDEVILMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDEVILMAN>(arg0, 9, 0x1::string::utf8(b"GTDEVILMAN"), 0x1::string::utf8(b"DEVILMAN"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/si-rLeTWdbBZLhLLs40f12pkCaG4aD78e3yLE0sTXYTyx_aUrqZU3ln-gRCxGJ8snpzkK12--QCfX_me_ku5cjWYru9AqSzVHfOiZs7DEwvPda-jlzwv6m_WNaSuORCRYxaVcxv-iDsPIJvl7T269wITweFndg3BHFEAJCjTrkSgpzTCz-Svhx9rz_D1AQR17aVxrAm32DtO1eyPO8U0TPNLkjhlPVSXgPC7ukyvXNxMiM-v6yOgiUKYVk-xW9DDivPvyL261-RuiEOZ1RTHbuaOyrxY65y-KJF_kqbmc_FCt-I8swtO1o1l9vIDU-ijHNVvHh0VKztF9OHZukf3Ww.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDEVILMAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDEVILMAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

