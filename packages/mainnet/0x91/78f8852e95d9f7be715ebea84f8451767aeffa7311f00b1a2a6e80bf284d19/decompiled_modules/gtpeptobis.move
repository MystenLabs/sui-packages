module 0x9178f8852e95d9f7be715ebea84f8451767aeffa7311f00b1a2a6e80bf284d19::gtpeptobis {
    struct GTPEPTOBIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPEPTOBIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPEPTOBIS>(arg0, 9, 0x1::string::utf8(b"GTPEPTOBIS"), 0x1::string::utf8(b"Burt"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/fuAS9p_HZ3E1pp7CZtDrlyaT3ulScBbmJD7mT_e13lam9puE-g-pKmn2lrRcinEarig-VTmjQvv94xPfMDenwNUpDsHHDylILVucufTqJafYMf8dLaG4mFhFpj1qvXG9kwW2choAfS_Clld5xi8nbuti2A5M8JHVPBWhEet2pgoHMTo9jY52eCF5064uBh2FdQmpQVgZOlWC-Iq1o6X2oqUxXg56NLA_GtuWYWQ5tZnABPxQ_uL6mTn6oYx1TfBefP-qc6p2UuNobvjCUnSekP3Gw02dB3wGiRCAJJG6bYWsTHp4lI6-lVPQgf8zbe6YZh1X6yRJGMPC0Aqm--1cyA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPEPTOBIS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPEPTOBIS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

