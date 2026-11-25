module 0xa400ce9c5c2c5e2dab273674c3bf95867a93e4a2ee7332f232f793e8ad818321::gtdoncurre {
    struct GTDONCURRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDONCURRE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDONCURRE>(arg0, 9, 0x1::string::utf8(b"GTDONCURRE"), 0x1::string::utf8(b"Doncurrent"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/IlxSbwwjx_iLyb_8tcmTjYTK3o1WPqujfV77NnbioGczO-XCvJC6PfFVlTx3TwMK4Eok9a2zEBQ62HEO5C-RdvhCHqCdOE1D8C3u7oEsTuf-Hr2ElysdprpbV6_00KGiv8UXBXzm0K06fWJ-QrV1wDW1HcI0e0BAS-OwLvQz9RU3V6Mzo1ERnSLVZrrVWGXpyBsVnfQ1ht-c-umcmejRsEg-YbqlVTLCyVjuzOO04cJ_YWLrrMk76DX_dsedBgTe7j92Be90kfhszEsaHJ32GTumhixvOXo92Ft2QrGa8LmvRZsTX3RDRCOJLnaq12-fffgLxJIw0YpMZJgARwwWcA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDONCURRE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDONCURRE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

