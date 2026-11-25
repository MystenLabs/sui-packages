module 0x5121e7102187b67da5409c9fe02c02f430ecbf4bfc3d106a669d032359a59c64::gtyeshendr {
    struct GTYESHENDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTYESHENDR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTYESHENDR>(arg0, 9, 0x1::string::utf8(b"GTYESHENDR"), 0x1::string::utf8(b"Yeshen"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/OtsIWUJ-L-AYI72ltkOx7oVNsa5uYI3PbVoYErQoMt2DayDXWvDKxburIYIkgFraHnHrat8T-GV9wdVtoVZu8oo6mFInhxR_-cPsviMYaE7RGiyYxDVypPUh0HWYnnhrU1N-qLmEHhuHEOhYCLsMU4R1WYz7ccvTmwFQIp4hJfjTgDqjeK3UO5cLhCnrMkkaXx11v6uFVFXvg5QS9XLzOKa90jXsLv0hb_v2XZEIG48_Vx-5woEFfnKbSviva9vQpxIlbvYoH9u-lG2KbKaj1sUuTbCaPBVyNWv9x-ulDeyb9fHBn8tqXQNF436v7cIgeqtuYmNdw7a2kLrLnFuoUw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTYESHENDR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTYESHENDR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

