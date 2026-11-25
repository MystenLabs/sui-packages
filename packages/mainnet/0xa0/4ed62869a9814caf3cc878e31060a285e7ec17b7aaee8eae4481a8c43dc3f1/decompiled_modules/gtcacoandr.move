module 0xa04ed62869a9814caf3cc878e31060a285e7ec17b7aaee8eae4481a8c43dc3f1::gtcacoandr {
    struct GTCACOANDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCACOANDR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCACOANDR>(arg0, 9, 0x1::string::utf8(b"GTCACOANDR"), 0x1::string::utf8(b"Carlos Andrade"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/smLwP3owRF7gbsUt8NQMrvAnSbsn99PS6dWnvCyZpF_Fh2AHuvkd0DS93OGRZRg_h0xtSO7lFk47dbvaoA5cxn4qbeJ3C5V2SdY7ikrSChNhH616iZp6G_gGTsBZMM0bdHQg6AOo9g-17QrtPwnan6uvtXY0CdfCKMAnFWK2krmgObc1-0jtFU99L7PbJ2HFLPWY6Cbfs00KrJCeNSQoGrFiS0CFX6SaKgsXiWPhooPE45wQ60H-9BoHx33ro8GLwVRaHy4PL5y2-33B46GBwKYG1pPzUsT8Om23YByr_wh4ChC_qSG8lF96GkIY20KJmpvFR1a-fZ4eKd0DIdRU7A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCACOANDR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCACOANDR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

