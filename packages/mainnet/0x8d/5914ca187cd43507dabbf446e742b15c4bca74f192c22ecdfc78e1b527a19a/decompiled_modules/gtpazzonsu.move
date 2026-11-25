module 0x8d5914ca187cd43507dabbf446e742b15c4bca74f192c22ecdfc78e1b527a19a::gtpazzonsu {
    struct GTPAZZONSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPAZZONSU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPAZZONSU>(arg0, 9, 0x1::string::utf8(b"GTPAZZONSU"), 0x1::string::utf8(b"pazz.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/sCk2_6Gqoln55428zhYjYDosjvHvXMTv87m_384y9T-UHXM-WQLDMgKwIz1RQRnPta2ST6O-PN9pF4_7VnyIsYBUXclHmfECCIJeZRAESPFLMBaFDzW0jtN19Ojal4R4rJbkbdXpTqRfvnYpr1Kj86p1S8_q42p4q8L6u-TMWvJMEEZzvm-WpF3eRccx36_609oZrPW-w0Ja56AbZg-y_1enH9q3PvRLPohFOWJ8JNFkI4XS52gyD67X2JjmQ0T_Mt0uFoZTovLCAQ8YtccuuEjj3oZx2o-wSPNIkI6UQ_d6oaylaJKCXdDtxWS7dXVyhUf0Kra6YCMoFsn0yWHNOQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPAZZONSU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPAZZONSU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

