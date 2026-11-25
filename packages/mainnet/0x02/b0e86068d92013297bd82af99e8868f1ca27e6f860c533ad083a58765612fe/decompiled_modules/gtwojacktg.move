module 0x2b0e86068d92013297bd82af99e8868f1ca27e6f860c533ad083a58765612fe::gtwojacktg {
    struct GTWOJACKTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWOJACKTG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWOJACKTG>(arg0, 9, 0x1::string::utf8(b"GTWOJACKTG"), 0x1::string::utf8(b"wojack"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/BnjG2_W98JcWDW6MqWUQKh1kbiC5iLWTa4MjhxfsT9Yf7JeoSyo5PSzOnCTwaLLCTUOMLKBU2udIUTr3f9c5GEs9NCzpovdELyU4d_NsaqLZ0B3OX7oxDflxnFiMn4pCTYX4ikh68oEH1bw9yv2Y9U3Mrly4vpSxoDqY57S70vl5GsRELU-c7qDZGNhIusSYKrAlVTzC5Bfw38Zh4C-wlFEdQYGqPhMogXv3MR8U1JFhAzsXF6sLpGRY--uPNvUcYoDshNunr6Z3LhMZp7WoSjM0cu7kbvcQuotkwGA8po9Dw-WRgM6lQ0-u552qciMUD5_rZOfK2MizgEFJyQEY0w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWOJACKTG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWOJACKTG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

