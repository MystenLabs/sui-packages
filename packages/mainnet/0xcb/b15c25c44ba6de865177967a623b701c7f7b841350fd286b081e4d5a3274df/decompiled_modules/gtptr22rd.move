module 0xcbb15c25c44ba6de865177967a623b701c7f7b841350fd286b081e4d5a3274df::gtptr22rd {
    struct GTPTR22RD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPTR22RD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPTR22RD>(arg0, 9, 0x1::string::utf8(b"GTPTR22RD"), 0x1::string::utf8(b"Ptr22 Rd"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/XUA_4YO_nA_flvv-BsSKpMwHEDPuKfTmiytH6FlSFMX0avh-WtI8i8YnppiZFjBEbEUyoCFeuglz807cfgJv0MSotzqy6s6EOKWXMIOlOLjxQ18u0P3C0eeT3gdQZCpiSdWam5Z2Hw7Y3Qjj5q56gIxbzhQIcVdCCKPJu4vuDkxnz2U8PZwd29RY4ZOhOEhPe0OSgEHMUHMr1O47Y98BGDxRI8kVt8G_CcdjVssdTy9G2C56sRazzEuo3ETqBULQE4cPfgHRcu3vDl5L77sFR1BGAfIWbB_eXajegcuR4BjnTdEKZuz4WHvsoiQ6r3_n7hwu_PemFRFx1uvcfxR91Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPTR22RD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPTR22RD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

