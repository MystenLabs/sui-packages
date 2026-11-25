module 0x61334e63637ec3f980910787f1655f6571e739d6bae99fa45ddf47885ed86047::gtlindques {
    struct GTLINDQUES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLINDQUES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLINDQUES>(arg0, 9, 0x1::string::utf8(b"GTLINDQUES"), 0x1::string::utf8(x"4c494e445155ce9e5354"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/XW3oooIzCe8_XgJ0CTae738_q81y6PFnFGWYVEwRD_n95HmHRUqWge0XiwVOhNEr9tImaAmd9F6fjNDdzHifA9rVw9UnCzm7-Oqjgrp4eJ7vn4BviA9zDguh_aENP0fqBfQQImAIYKBKMY1560Tp6QFKAUuPosjjLZUYb2aNy4BJs3AsYGmc3ce_5xUVvXJrdhhOVbINnnIR9-tIbXdMFiytCbIj1DwlBqAF7JPoa9aLXAsaHW1guXNFMOG4L4p4CVpR4BV44y1LZtgAQTg93rYiiX3woooQKLK9RWTmYvb60W1-zM-vwVV9fSMljqNxz-gsGXqXs_wGO9unL_S82g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLINDQUES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLINDQUES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

