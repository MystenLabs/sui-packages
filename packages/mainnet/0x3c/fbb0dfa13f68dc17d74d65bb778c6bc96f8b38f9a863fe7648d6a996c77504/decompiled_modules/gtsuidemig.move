module 0x3cfbb0dfa13f68dc17d74d65bb778c6bc96f8b38f9a863fe7648d6a996c77504::gtsuidemig {
    struct GTSUIDEMIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSUIDEMIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSUIDEMIG>(arg0, 9, 0x1::string::utf8(b"GTSUIDEMIG"), 0x1::string::utf8(b"SuiDemigod"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/iuD8tN3MpYx6WvT0yVNRkJD1cTtLjRsHertK8PDv6flcqwhl-FzHPAX-dkwwkowBWcwPNTnGbTlPtBqC4Xo3b0DvOb0AIpxJl-WBfnXO-5FOGUGt5zSFx5obz3hXk-3tfLaWQcXSR3Zmm8YxoZ-omKT5CktghWxIHi2Ioo4p8R0ynGCw_hLVPRUHWObmV6t7i0gp-SpsKx5HzVCJZrVJEKDWDVcK7l7VCgowSz4y_zOaU5jPDcLJ_J0sCUm-rAgj4DoclkD8fRrAaew1L-rLLVj4v2iEpi_Ghn-fRlQGA9tRJ2LwfD-bxDC1WEsio-IKo2sWecSx1ErSornbr5E-fA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSUIDEMIG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSUIDEMIG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

