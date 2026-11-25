module 0x8acebccd6dadd8d80867b008320849376f24cd5d881f6e581e361b904ff279c8::gtirohgmi {
    struct GTIROHGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTIROHGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTIROHGMI>(arg0, 9, 0x1::string::utf8(b"GTIROHGMI"), 0x1::string::utf8(b"Iroh"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/OnWPtldaIKFVRr_EGm2LSi-bHb0IWs6Wnhsm58o2tL3ho6SoaNO0Pg4SR4u8DWYDUzRCvS89Py97lR3QrqwDnu9gKoB-4Cc8ezcDVZoZxJGZGDBRDc2Z8nuxh5Abnozv2ra5rNouY0WmiW2sPPhAxF0erLQiwJvJFfJhkiu1J72t7m9J3RvZx3upwm6uvNXGIuBJ0BlRdqiPugd1MJQR5ZLwGlBxk3yce7FBcHmOwGaJghOOnNvZjMJYEGino0bV55vRtgDBXq1yGKm9BFN1FuV_ny0wVe-MLYuWf_EcW0Byd3rMVHCppj72n46F-Kg5Equ942EBkLkldYWHxk8ocQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTIROHGMI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTIROHGMI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

