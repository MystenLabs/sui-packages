module 0x4bdee17813190be98eb6a132006253270da384f729fc5ed54888f4262b1ce552::gtmikecant {
    struct GTMIKECANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMIKECANT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMIKECANT>(arg0, 9, 0x1::string::utf8(b"GTMIKECANT"), 0x1::string::utf8(b"Mike"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/t3XO0NjOPoNKQz_1yVuA7y17t70s4otZy_acrc-35LigJGufGeEFLIGHF7tQg_gcArN0MD1I9VjJAU7EgyxYxxFmNXg8qQSbtnTm10bAuuGs5Mr2HYosS4n3HCcrjrdKSmuD6rDtFNq-ETlSxlBe9G436QEJ8e8O-HX88HM7wlzH4ms4ZiAEmOceRBDDk_q6X2jmsIuwz-7srxm2KyGSTrSRGU2FxuzDnlRSg-YRt1dMgIcsMLosdiXUf5pNB-wP1aDNJ1AhKQyt5itKInObE_sOjWL-d4nxjZ1CJKqIneI1552QhZe79nL4ySajpwG57sakIQ2DK95CJQ_QzTbgGQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMIKECANT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMIKECANT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

