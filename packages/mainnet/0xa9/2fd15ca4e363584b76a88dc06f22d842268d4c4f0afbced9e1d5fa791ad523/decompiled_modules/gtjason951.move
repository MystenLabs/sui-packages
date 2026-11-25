module 0xa92fd15ca4e363584b76a88dc06f22d842268d4c4f0afbced9e1d5fa791ad523::gtjason951 {
    struct GTJASON951 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJASON951, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJASON951>(arg0, 9, 0x1::string::utf8(b"GTJASON951"), 0x1::string::utf8(b"Jason"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/dIqeRdOtHK9k8f2AmYhHs5oFIfvNaeNa_y1cIPMaV8wTR8LpNeLvPLb_r26D3RJVgwIXPQ2KqheKRSL1E6s7kDdgcB9EcDgyDdpYeEz5ct5Uvn5QXwNMGmxNlqBvaonJJ4TEWc1XpTmyDuADCi59F9pA7z6c2j2vdZ533oIVWrbSfXn0va7Znqt_WIZ_X4uZiAXKUdILa4LtUdMPxlGpXHR99jJWZaIYzj7cOQlPJMhgaDzpylWFNAIDAlLAmBO-W8lKGF8P2ASRZrOPE5dtiz_nBCjcmZLxi3vjzZFVJm_4_8gzuR3D1SyX9W0AniD7HoKN26i16vy1S4wnf4aa0g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJASON951>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJASON951>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

