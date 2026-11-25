module 0xefcc4f9010d3c8346e5aaa34db3ea5ee0a25fe10caa4b4338399926da91c2fa7::gtchocolat {
    struct GTCHOCOLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCHOCOLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCHOCOLAT>(arg0, 9, 0x1::string::utf8(b"GTCHOCOLAT"), 0x1::string::utf8(b"Choc"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/RADVznbQ6LqKYbiXtlUErSOhtv5UuQnuDEB_lR70y4XGbeUrH8lkxVCNIFyBjVDiCDf5WUkI0xsXRoYI34vcQ9oyA_7eBEhiYa12wsrikodMAD4xHfHg5Pn8WwsEVesMInJAXDGL6xgf_s1VtAA_8d_UYgFvRg2dV3HYe1ecHTbLGXqudEP1v1k3cMoyNwyYaMM-FJfvDYu1_YIj5S4oOc5gK3-qdNmNiAh5FizUP8a3ydXzA-e5ddrPuKZI9Jjh2WTRdFEgCjh1IUIfPwLAIlPNi7LOPp0d5ZdOMg3CYO3Ev_TLG7hVeUSHMvF3TGmQxMjhNvOlYDAlCQaayBvjpg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCHOCOLAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCHOCOLAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

