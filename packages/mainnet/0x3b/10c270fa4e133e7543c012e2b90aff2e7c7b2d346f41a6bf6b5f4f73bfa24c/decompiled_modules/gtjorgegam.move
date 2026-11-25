module 0x3b10c270fa4e133e7543c012e2b90aff2e7c7b2d346f41a6bf6b5f4f73bfa24c::gtjorgegam {
    struct GTJORGEGAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJORGEGAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJORGEGAM>(arg0, 9, 0x1::string::utf8(b"GTJORGEGAM"), 0x1::string::utf8(b"Jorge G"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/RKutoAKXpFK-sB50Q69b-sc-f-tiP3kjfKWjFE1aTjg_Pwv-l4eKv-ambhSmUmS1JnvdyOClaOVEmyyracpFhLvVA8NP3DHY9YeuQ2VjB77xBgGUNTBnCiIpusQ-baEsojZWhCpdgtDsiPqW2CboM_ITBbXAT-V_f9IBCoOPwWAhQUWu6pxtzG6KczjFM4RRViOxVjrUTQRY3XzQIjW4uu5EvZzUdVwzOhF_vfP7XmS_5LzDUlmBYIk0X7eqpR3sPt8BZ1HssBznsoD72EstgCr6n6Lc3jBgziyI4jRU-jZ0fYPdSse6idpSvB_cSXd2snHkwwIYWghMtopa_LTExQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJORGEGAM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJORGEGAM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

