module 0x9d377941277f6ab1ef0274c16861a52ac2c8c0bf8e5f0386b256564d519f4daf::gtcenturio {
    struct GTCENTURIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCENTURIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCENTURIO>(arg0, 9, 0x1::string::utf8(b"GTCENTURIO"), 0x1::string::utf8(b"Thoumeaux"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/hlyw5-ksNKZS1ZhBJb3MuEbq15ovxURhCTePcGWfzMdzxqc-z0fCS4_7ppzgpPWSkV_nMV7f-b3QDNtiRwEgbwdhBH21-zoHhp1lWZOY2Y3bgcQATAH5axxXmTjoB67WidvZqtCn6pLR13Jl-B7U347jJoY-wNcqx0YaOjcEp5r5qLwVloBBl78JvFISLEBBXqPt0CRLt87tmuQpvQiz1G9mkzfFtPM6njzRoaE0yjDv5jVol-7szr4NiwJdoVIbCTux92a_S_R9yFL5bZtPMEbh9IvTyT_kzpKfWRHA1XILLl4co9skMDVBK6U76GVqpuOysnj_L59z4CUEAhgU-A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCENTURIO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCENTURIO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

