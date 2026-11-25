module 0x21d57212f3d03c22f3d19888f544c99f7d8beb67754d3c6bd17b4e2b60e5cd91::gtsilverha {
    struct GTSILVERHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSILVERHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSILVERHA>(arg0, 9, 0x1::string::utf8(b"GTSILVERHA"), 0x1::string::utf8(b"Silverhard"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Rj8i2dKpJ_X9Wxl0x3-cbzAJaYx-kC8MV2bMXG-qklJFRJCpEPsGmYvraY1ZusZO0WpG132MslEFlr-EdhRtMl9dcW_zUJLRlyKfZmRMiSJdh6qUfMASH1fOEB-AfPZg5EzhR0kISLmKOHCEctwWC77DMQCWaQrUPj1UFKqXlApgFPV95UQ34YH62WcC14-u8RAtGSVyq6eh0_RKP_t7gdg3G6jwQEiirF0wy2gudkz8WFVux_y7uC3jGxVE9jA9A-gAt6GM4n_59MfhEIM3MFGNxmIX6yRD42NeoPCabK0hG2V6nn_F5CAv22UX8Ey5eDt-S6q5hdRs-UFtYyoOsg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSILVERHA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSILVERHA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

