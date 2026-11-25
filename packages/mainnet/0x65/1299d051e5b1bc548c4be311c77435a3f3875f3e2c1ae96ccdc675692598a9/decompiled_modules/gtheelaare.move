module 0x651299d051e5b1bc548c4be311c77435a3f3875f3e2c1ae96ccdc675692598a9::gtheelaare {
    struct GTHEELAARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHEELAARE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHEELAARE>(arg0, 9, 0x1::string::utf8(b"GTHEELAARE"), 0x1::string::utf8(b"Heelaaree"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/RIU2W9sXZ67t_5luPB3XpY3_UPPfglVXftrIPH69mYtoNEmAit69t5M_9JKQHaukp44wltSD0GB8hAq4RC8xVaj8Tf-eiHmp03ZirGJDd_j2spXGvKWLRCB9RZ_jrPFZBdUGxUDPMqKkVzhlvknXsYuS3zjufM6a5rZSsAr4oDJ70xsyTkACJU7cK5Xj2o54OOff4IBoeRBMJfyoWnWKFg106K3Lv1fPlVvpdhThPbIKirdYEulvrTMcVbAooEDwDC68IS1IA3eLZJFyptgOnkcG17sVCNq3xu_R2dLYJ0-BYG6iWRemTiI6DoP93zndvwOUMUPOie4JNYov5-Fj2Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHEELAARE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHEELAARE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

