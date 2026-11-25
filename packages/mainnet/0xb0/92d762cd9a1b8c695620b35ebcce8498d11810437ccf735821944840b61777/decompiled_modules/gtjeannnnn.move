module 0xb092d762cd9a1b8c695620b35ebcce8498d11810437ccf735821944840b61777::gtjeannnnn {
    struct GTJEANNNNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJEANNNNN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJEANNNNN>(arg0, 9, 0x1::string::utf8(b"GTJEANNNNN"), 0x1::string::utf8(b"Jean"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/mOHVqO2AibfKhbVUr0LFOU6bVWr4hg7imegtIpH344LDrPjYFGhZSJLciNMiHqbQ9GSh2lzyGIaHK6AEQG0EiP5yuC_PvcHYe4XTipON3VV4OL0vzWNjH1glQFk9jKmd4qWdF6OD38MIPmJbsEzWuNyFL3NZERosU_MrkNNqcAg8n-ocrcx99UqFneBC73wzv1MIiiGvV0rMLIxiKflqGKVIA4PEiziQeEAdmZIv_tpl_KEOz37n6xh4fb4z_cMFeXUpAgqM9T9OhWPHqfBerw3_WMtGKp-NLZv0joQraQy8Fmv5xDcYQ91KwBpkvd1rOEQUm6jFY8wC1IWDx2X-hA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJEANNNNN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJEANNNNN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

