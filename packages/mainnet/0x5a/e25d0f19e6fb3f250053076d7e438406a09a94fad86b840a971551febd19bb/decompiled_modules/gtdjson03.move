module 0x5ae25d0f19e6fb3f250053076d7e438406a09a94fad86b840a971551febd19bb::gtdjson03 {
    struct GTDJSON03 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDJSON03, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDJSON03>(arg0, 9, 0x1::string::utf8(b"GTDJSON03"), 0x1::string::utf8(b"djson"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/mVaVEr6EkDf-sHFg-EAS_CxpLcr19EpH5DdMXx3uyKygJ9xfy7cvKb_vYJkCcUxvbj8CuIeJdiVXfA1hbg5sdVM2S03sWppNs_ZrHU2gIdqfw5t-xm8H7xJcu3jeh4-AEcay_dhR68DMvpyuroWIeqt0DbnFunO_ROWHODzpFDZDqo5XYX0MNeycROdQHFABXppKK4JoWSmFGvmgdZ4rD3C5XI97PNZKU_-y6dSAKdGGIBNg-tt3XmJNgOXrEvg4XSfXOOqWJKKBbPRJHJoy2djeIjkw61LwqRpR1D5MAhJUwi7-xjRlBl8B7tm5h7frfuDtKgfKPaSEylxt1DnIFA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDJSON03>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDJSON03>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

