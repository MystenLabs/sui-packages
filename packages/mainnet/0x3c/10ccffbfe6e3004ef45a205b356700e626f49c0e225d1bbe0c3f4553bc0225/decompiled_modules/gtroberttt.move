module 0x3c10ccffbfe6e3004ef45a205b356700e626f49c0e225d1bbe0c3f4553bc0225::gtroberttt {
    struct GTROBERTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTROBERTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTROBERTTT>(arg0, 9, 0x1::string::utf8(b"GTROBERTTT"), 0x1::string::utf8(b"robert's"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/BopBrsXzQgdWrnBw_Hj-d4gAJQ4E2XS4PIeY6qAubNGNET3RwvtcitGU2fvlNQKZdhkW9amJY_qVql5Pk3ldE2u__gDCXMzAuKRyq2FmvywgTLgZXpW2gU_TjFIfQLYDHvxFOa_T--fJczfshm0Mvaf53Soj0U_ITjcvLkknv5nxEHaYlu1SgKWVCMoIddnIs-06qVj9BSMtYbJpcX418rQtkrGjhYQLord_bLlImiUaHqwv0tQPaji9olkJP9NxZmmgtAe9ebBRmGzSXI_K4WLNAWZgPb4GAWQT88QFL69Y3wbGKUZlCkv2GiCRroD3GBOa27VwMznKF3oUO3_yrw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTROBERTTT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTROBERTTT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

