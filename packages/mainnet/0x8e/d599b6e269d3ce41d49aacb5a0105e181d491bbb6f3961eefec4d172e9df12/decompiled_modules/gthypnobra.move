module 0x8ed599b6e269d3ce41d49aacb5a0105e181d491bbb6f3961eefec4d172e9df12::gthypnobra {
    struct GTHYPNOBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHYPNOBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHYPNOBRA>(arg0, 9, 0x1::string::utf8(b"GTHYPNOBRA"), 0x1::string::utf8(b"Hypno"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/QXFYCT2z-4dL6VWTBShyJUySqRY0xcTuCAwEIJcz9FX1HJZ5hvtPYQZADbKfgo_tGREENCW9IXIoEGCYBdIW_VMoUsCmCuTkIf3MBqjPK0oxYEkmzk-miYa-a2py217ssjvz8x-YsqVIyoPQfUOUCXWheuCbBaeI5UZZ-gt6Xsam4lAB_EYCH7A0Mtr4cdqE5NSgwNlKveN9TPXzLLX9CIVLlxySRbGbkWBuhQPit5dIaI0qfthYTQS9YOtlEVnSJM4rkDQ_x46FRQoIUCON6auLJp6hOTNGPSNfqyoJazvnbMEv3KULtADksP9YkaURX49XRvldVexlCzXP8kuL9g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHYPNOBRA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHYPNOBRA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

