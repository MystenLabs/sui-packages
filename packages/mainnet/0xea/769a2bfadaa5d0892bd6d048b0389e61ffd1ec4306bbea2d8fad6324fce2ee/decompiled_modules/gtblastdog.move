module 0xea769a2bfadaa5d0892bd6d048b0389e61ffd1ec4306bbea2d8fad6324fce2ee::gtblastdog {
    struct GTBLASTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBLASTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBLASTDOG>(arg0, 9, 0x1::string::utf8(b"GTBLASTDOG"), 0x1::string::utf8(b"Doggy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/QSQh9UCExeXHzxnv1B-6nitR3yWbW-fctaGZQrnCm_iE8wCX6RVyCN0FTf2lxIVhNe3_gy5zOftIK2RvoDOE-Hld9JE3Dvgkd7B3cWMYPxaGGGGm9eCTVE_zb7Sw8WrMNX34UqG7I4T3qUbnauuRwr6wQarczAb3z5Jt9rIK7tb31-J2SmVq2afWpI6mrBTL8TaF0EU7EEPOWp70W3459Bf0K2Ych-KLGAtUoemdikKoFwqTnDhZDA0OoeWTWU0V2T_Hsro6gABMkXF-GTV9UKHPhlGOIUDvPYUSds0pI74KoAqFczlLYZXYqXb3tsW-go3oapxJSv__kGAaRP_Vsg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBLASTDOG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBLASTDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

