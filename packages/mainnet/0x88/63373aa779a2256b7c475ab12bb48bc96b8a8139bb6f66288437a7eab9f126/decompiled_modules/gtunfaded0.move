module 0x8863373aa779a2256b7c475ab12bb48bc96b8a8139bb6f66288437a7eab9f126::gtunfaded0 {
    struct GTUNFADED0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTUNFADED0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTUNFADED0>(arg0, 9, 0x1::string::utf8(b"GTUNFADED0"), 0x1::string::utf8(b"Unfaded"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/nOkOGrZs9B2xzpM0bKmGpJpY73OafBzfDXqkIuN06bhJfKELH71JGnf9aEZCh456AiTUyWP192CBy_bobssgcA1dFfjRjSfe-SBOqwHkbMscTjMdgAEGuXB_7Tf4lblR-P-niWDKI181eVu7S7QypiK4iQpvYkMHfTVyyJQHJH3-g8B6bx2rO1vqnZ3wxCWK6jvWU_7j1yakguLlZEjkU2O7PABCvaQf2LHPfzMS6by4VjUd-oiKS8-dtGfM0T1hJnKoA1lcxz5GwzxxRtg5jpgL1hsULGM3nzToJrdkdDEZcBuieAQzl3-ZB0cYoT0BKyfIM_bbsZJZSG2RgbCP1w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTUNFADED0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTUNFADED0>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

