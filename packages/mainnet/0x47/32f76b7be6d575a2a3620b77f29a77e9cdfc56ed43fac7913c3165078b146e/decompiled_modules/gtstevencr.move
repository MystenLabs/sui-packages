module 0x4732f76b7be6d575a2a3620b77f29a77e9cdfc56ed43fac7913c3165078b146e::gtstevencr {
    struct GTSTEVENCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSTEVENCR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSTEVENCR>(arg0, 9, 0x1::string::utf8(b"GTSTEVENCR"), 0x1::string::utf8(b"Steven"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/lV-VBrSxRDaVzJPMAwbgGrRBpzONygH9TSm-6M7SnUH_JwQJhv9Hw7jGB7aO8i8OcpGfI3Fj74kU0ooo2F_MciS_ZhII5zHnltiW4XMgKZZkynhEtgDcvpZDC5kUvmNwv5p1CBlOLpEZgRtCMt-JuE7p_cU_juXibtaho7Wyj1n4zsYn_F5rLY15U0FHk7eTsSkTLibnV2UL5GbwdH3TtRY3e0LqehfO_7zZvT0jfPDBrp4KLcuzY9_9HQ4Ry8g3EqV0LIp5eUOYO2uvg49IxYPuWVYLPo5WByV_hUa8CRsM8NkSHrCaVuoMN4vnr1F1hVinwWblucpckeCznOt6Kw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSTEVENCR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSTEVENCR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

