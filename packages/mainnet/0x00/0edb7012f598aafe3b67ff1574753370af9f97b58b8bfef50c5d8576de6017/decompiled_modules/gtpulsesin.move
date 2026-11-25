module 0xedb7012f598aafe3b67ff1574753370af9f97b58b8bfef50c5d8576de6017::gtpulsesin {
    struct GTPULSESIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPULSESIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPULSESIN>(arg0, 9, 0x1::string::utf8(b"GTPULSESIN"), 0x1::string::utf8(b"PulseSinister"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/tG4feuXLyrb8b14zYPzHm2ThLrLvVVG4AlZBXyzBocam1xoDczDRx_DZCFVnGWdCXVUWpOazvzT5yIP3pH9tWBML5IiemeTfe78Hc6a2LbTcsW02W59yr9QGiJtc_h-Ki83rDz-kGzAhFO3b6JA1LMrAbbHMUTO-PTTCDZjShizQs82hRoN6IC116PuRpY-O9_ntnrS1diru2yybbT4Q8SpxLaIlMRhI9luxyIsvRCtseM48qYZ7cQjUzQnN9QrRA845cVYlsvnpOWb0-J4rZg7TkPdWY6H7ohWTyJdkrJRy-bVG4L-VV2k9ndeYIimlbdmJH6EFAQf37m5SbpCSVQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPULSESIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPULSESIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

