module 0xd6533d31acd704d9a8df841a946a8035cfa7de18ef47b3c86a4ab552b800f2e9::gtwholesom {
    struct GTWHOLESOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWHOLESOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWHOLESOM>(arg0, 9, 0x1::string::utf8(b"GTWHOLESOM"), 0x1::string::utf8(b"WholesomeMilkshake"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/j5AjQCP4N2vH9O4te9Vc4piikDnxgCRkTP14sfWmHTvV_pUW_NwGJ1sar9echBuHSJIsBsUklBAGx3y1SA3wQ_ZraDCzCaQzGmt-Eq7rVhXx08o8GLT-WJOB68fB0itrc52UsB0mnASATTSoZrvJrscnY7xHX1Y54QuUSFWmuKI-CYAfVXYuMJ5mYZLJWFcoLxHkLc-skTaUxxO1Hhcci99muyLJND9fWO1rJ4Nh8q7FRnIsDPTnuqcD7KkFRqlDqYz3jPzMgx0Nyz9CR9Ix4-wKMkyvMSGzTja6QaSI4_heES3pkKvzXyZBCdiqRk3SLwxtVwLjLa8o88Dvv23Z3Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWHOLESOM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWHOLESOM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

