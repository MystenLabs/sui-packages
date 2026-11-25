module 0x42e6476d1fd15b0437d555cb73488b699490a5e35b283a887ae1175b871f1771::gtbharathd {
    struct GTBHARATHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBHARATHD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBHARATHD>(arg0, 9, 0x1::string::utf8(b"GTBHARATHD"), 0x1::string::utf8(b"Bharath.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/g-YSDlDMkhvwFuisOFepf_E0bK605z9i7bnhQKx6s7pDeC8bnvNKZShUgnzIxdu0VeS1bPhjUdvpH5HZISW76LfuGeAD3FJ9wsP2Eqys_61HD0TtG3uTEIG_6rGvZe96t8GjoLGOoVh0bTSSorh4B2qagLOrmv3-suVtC8wldTL_GBnEEfdbB_1465pITI38eKo9pd0zyDxDN3M4_N_EXpqp33AZtG9WBeCbuQGNDsm-3itmfQCuc-tJtYxpn-BhVz_MFTVpLadsOsLv7KIYOu11fU-rOzL29I2NZvzKbNezlb6nNi14wAy-1UUSY_XyuvxVGIrADq1Knb0Z_Lbr_w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBHARATHD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBHARATHD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

