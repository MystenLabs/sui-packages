module 0x3637a1d9a29f03324393e93d3b004505aaf3c03b4ab39dbceb1c7cfa6e874e99::gtnigarf {
    struct GTNIGARF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNIGARF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNIGARF>(arg0, 9, 0x1::string::utf8(b"GTNIGARF"), 0x1::string::utf8(b"Nigar Qasimova"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/halm8z1lC0i-2tUpc9sDHeI197JGZZ5C2PtxV2exGuAg16WEkYvSl2b08sJ7yf0WGOG2Ymhp4TqKGWMIW4JXCjIGtHJD7fk219A4Kz5YrTo7I_VrzrUuw76BSBSDnhG7gS6GLT9ibmlgFhEQWdkANRyhdrbAPpviqtEK9z6-ATWiYqudMwwdkmQKaKyM7lt3LG4FnUrGkaro42QK9S4-DI4k3p02x1BVYB5lkymPC0GAGYoFqoKnjvGTA6RTKmXu2LiaWvTFOMuzUW8inljAdGbR3JGLI5tXYN_3D7xi2XzFnm29bTEH4Tdz2P6M9HmnTPNPABbwjLaBeDZ0thBLIw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNIGARF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNIGARF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

