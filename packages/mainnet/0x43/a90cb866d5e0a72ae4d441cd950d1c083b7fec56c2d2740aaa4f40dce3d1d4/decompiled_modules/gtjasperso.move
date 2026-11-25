module 0x43a90cb866d5e0a72ae4d441cd950d1c083b7fec56c2d2740aaa4f40dce3d1d4::gtjasperso {
    struct GTJASPERSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJASPERSO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJASPERSO>(arg0, 9, 0x1::string::utf8(b"GTJASPERSO"), 0x1::string::utf8(b"Jasper"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/loWMyc2LicNOnkRRi7NaBYx5Yh5d-efVMtRW7xcTtQfpZO2Z5aA5HrW43safjSALiwtyTLcc7t1-tNwPPXZDAKwk66WQa0DYGcJlLeT3zdaYZdAr352j_PO0mg-9SGJJgIahu2QqyJYG4mAzJI5NFsVhSBkFmyF1oVp330PdkTWR6BK-3DRyXzaLB1RRwT6c5u-DforREFDXmTP2QudkpN_CJnwLTt6G-mwiEADUm1X-EsHCpIBco8XPDQr1Er6bvxPbT4F0VnruZhuAOaqHE_GmetgNxEZVKGnpbirLwAz8OiTl2iHtpsILayOaO96T7LdJolwGA3Q-xCQaLlsTGA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJASPERSO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJASPERSO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

