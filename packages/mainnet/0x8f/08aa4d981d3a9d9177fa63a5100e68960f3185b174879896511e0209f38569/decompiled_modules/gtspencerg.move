module 0x8f08aa4d981d3a9d9177fa63a5100e68960f3185b174879896511e0209f38569::gtspencerg {
    struct GTSPENCERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSPENCERG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSPENCERG>(arg0, 9, 0x1::string::utf8(b"GTSPENCERG"), 0x1::string::utf8(b"spencer grey"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/dGeABjYcviwUa57TLnXhlldppD_dHRg9Gmwvlw7ploCOtO-54fssPDM5MBLtwaflkPBwdlNseSEyOsUQTvxyu0-t4AE09jCOILS6LtFDLDmtaGdIFUjSKOL-E_M68H-FWyLNaboRcMATez2NPQ9Qq2oWA7TQ1x2DIJPcxLai0IseX5I40F1AQPTcA6cxsODdWxonsCPVtVfuNS4KzKTxyHnfmDOD7uD1O2SYZUhUAy4XY-U8Xwe5N6phE3IfIuAOj-IMGYW_PgTFh4_H1B-GIVZx3SUJ7TLNvbGvxzkc8a4BYTShAebEWPmLN-0LI8Ikd_QQVf8DH8sXufd2I-75kg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSPENCERG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSPENCERG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

