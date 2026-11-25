module 0x2cd07f95aa2fd2b099447a7d46ce2def5102a1b6531fff9d95d3327951208f3b::gtmleeos {
    struct GTMLEEOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMLEEOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMLEEOS>(arg0, 9, 0x1::string::utf8(b"GTMLEEOS"), 0x1::string::utf8(b"Leeee"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/N_8qOhg9vT88GmylXXCd1CYfLvTSJrXSWqeoqKrpiPKjEUbVZb4fxuGMBtED9zRmAJyoEGVW1h-9o-qQjJdEjxbjN0NKcD42p08V5sNiPtuMUJGiPfwyHgux85pABs-GrvTSmHUWaShUWwiQFW5MCsl_mg7pPaxM962yUFBWnKdlAjh6puq9k6w5UbNNJBV2CiUrCWumUw0V-UW0lFMNMWgvVZwP9Hn4q3aKnW0DsLFtzqtf9DslKI7ylTG7yDhGthg12SDPyYTbUUxDUvo_j8rGP4LCZfyZw-ZpVGTWqrvXt0tRtpBGYIXOg2UdY3jcc84h19pzR_JWNRia1R6g7g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMLEEOS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMLEEOS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

