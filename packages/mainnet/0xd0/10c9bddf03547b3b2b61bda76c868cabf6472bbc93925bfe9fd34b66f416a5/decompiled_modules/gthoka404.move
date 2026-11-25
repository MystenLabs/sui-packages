module 0xd010c9bddf03547b3b2b61bda76c868cabf6472bbc93925bfe9fd34b66f416a5::gthoka404 {
    struct GTHOKA404 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHOKA404, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHOKA404>(arg0, 9, 0x1::string::utf8(b"GTHOKA404"), 0x1::string::utf8(b"HoKa"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/ubCER9HLnWutFTWmYts9gbMO7Rnat8MyW3loZgJu0kVVPUfYsimES6d4nYI6mtffbQ_aphV9eudAwTzfqzoru_6yR83z91Ei8rc2l0BC5kgrI0KwfOd3X5kpIejLYY7qTuJ-yJsjIaSnK23ZuXVhipFbf868ZSaRCbKJUI6OfeE02bEYDnF6uJomA0ZmuiXiiTdvtDjYI8asxmbZZ0N2ybWU16ru8ODBAdFqMMeKDCP52D62h-8hjd-2NITrGiZ8P20LFXxvAkMHsTM_SxUpubBRZltc9WfvYKeCEGRSHVeOVic6mUj6T1zYTQf6ivnkDZAfJd3YLxhw-p8PkfWsqw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHOKA404>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHOKA404>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

