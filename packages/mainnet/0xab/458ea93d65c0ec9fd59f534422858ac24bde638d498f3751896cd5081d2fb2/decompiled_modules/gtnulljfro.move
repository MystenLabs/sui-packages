module 0xab458ea93d65c0ec9fd59f534422858ac24bde638d498f3751896cd5081d2fb2::gtnulljfro {
    struct GTNULLJFRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNULLJFRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNULLJFRO>(arg0, 9, 0x1::string::utf8(b"GTNULLJFRO"), 0x1::string::utf8(b"J Frost"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/qj_sqzRy2WWl8L-E6UAH-0V01sKH0seA0aK0CvQjKfwoFV9cYjXDmfhfMvOjJxMNhZOwlkEgnOnRiGw65DlEULpnRpqT_tpHfsKHaEgJQhGgV-XSQMjcB5vPk1RFoXzm--by4ENKnpYUt2_b7jmkfTkAXzfmC7TB4wK7gFxBZlKU4cCU02DPYO_6Nd9DBuuk4SxRCxrUouvq30Awb2TKqO4LAYUaMtVs4JqHBeQHtXvQqazP0WiYjSJ3Dxl8_IxvpfembH-oRf3FTDChbjDVum5loyurbOFG9HzPLa9zu2AnDMMNNZX9lxRTljjH0e_t_x-Wmv8Rq-PfTxwZ5Wsjuw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNULLJFRO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNULLJFRO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

