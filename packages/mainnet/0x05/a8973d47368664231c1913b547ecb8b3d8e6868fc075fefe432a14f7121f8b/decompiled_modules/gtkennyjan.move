module 0x5a8973d47368664231c1913b547ecb8b3d8e6868fc075fefe432a14f7121f8b::gtkennyjan {
    struct GTKENNYJAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTKENNYJAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTKENNYJAN>(arg0, 9, 0x1::string::utf8(b"GTKENNYJAN"), 0x1::string::utf8(b"Kenneth Janzen"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/MVXghOypDa40DKtZBtTvdh0pupaRR2R-V-GHhW9pVI3QAcJgNe_CJP1g_QA5evIGFNPhSPkOdky3M7qLRY-IB3fq_WKUGgAw01WAsGO2Fu5-vUk0LtBDzp-PO324XODl1raZytQvf5XEL5d-anp2oMMAB2wlGU0pCfVW-HdG7Rrl8dhXHKU09qgD07HU5GcDEqNxKXDt5lH6pE7Q3WkjjXIvHf0htobtYGPBkom7-FXrboo0s78lH48N_RZ7eZS-tM3QZXvuDXIBp2YTLhFuFutr_4l70stWJd6s-nJcYuNUaBkqeCsDHvCevH7eNJRp-cNVvG-BXB7Zl_7DN7JWlQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTKENNYJAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTKENNYJAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

