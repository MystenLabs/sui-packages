module 0x557b3471397614e6c584894a2c60e0f68eca88ae5e4eea89226db9ec0001fcec::gtxsuhair {
    struct GTXSUHAIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTXSUHAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTXSUHAIR>(arg0, 9, 0x1::string::utf8(b"GTXSUHAIR"), 0x1::string::utf8(b"SUHAIR"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/eOi69ymEEvaZtc9K-PYSSJdynqHr_ZCrvESVO0QLhSh0n_NHWboQr-FlhVp0dxuMZm9eISeeDvZvMlXz98uTUgqXaqhpoL4KoOHYNfwt7paYI3zcm_XELhr6uRGrT-dIJgoS2RapkgiWfqD3CwNiPdZHNjGC3zQOxUJYeHqYmX6FVlwJjCrKSsTY10TMo9luOxghg9bg9jxiqW4CcK3-1UhVGBU81ymRHCO5pJFdMqEzRZX1I-J2UfUQGRyPiYZmuJ2umb23y0jH-ajk2kp7PNOu-EXrnVhVmhWpRZuzjlQo_Gyozs1Ld8qxNGPMpE2feUNOIEsXrPaVzmnuyCYp_A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTXSUHAIR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTXSUHAIR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

