module 0xfcfbfbfbd31e9f5db7485e473dcff5f12deb8f0d1d3d4473443c3301bc30e02::gtomobacry {
    struct GTOMOBACRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOMOBACRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOMOBACRY>(arg0, 9, 0x1::string::utf8(b"GTOMOBACRY"), 0x1::string::utf8(b"Catalyst"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/I4HWeasx9j8TrMbPlXrIKFKvBevH_AwTXbbLcfK1UEZGz_u__iRM7MvqdDsOma7qKcNy3gXBHZ5-x7VHNho4oiwTOWLvyg4bRZt4_Hg8IDCoumlr4qyKxq5J-VDmuuvSkyEauxmHvdBVpVR2DC1rJhTq5DIcGSvREPaJ46OQGVzeP9cMFyKsq1q_aq_qYqKFkMUpsNOG2xD03wPPLGTtOBV-HeqdMNk6-nwWlJbOJl2xCSWdfglyWRMHxojY6wq9CxTgkfmb4IVNVrd2aeDyiETLUvMYEhZvwl0rQKpvTL_L0CKJszDC4u_-me9WQe68HV76haTxHY63ojnk53iS6A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOMOBACRY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOMOBACRY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

