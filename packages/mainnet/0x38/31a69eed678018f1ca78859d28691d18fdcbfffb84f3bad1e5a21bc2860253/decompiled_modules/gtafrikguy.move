module 0x3831a69eed678018f1ca78859d28691d18fdcbfffb84f3bad1e5a21bc2860253::gtafrikguy {
    struct GTAFRIKGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAFRIKGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTAFRIKGUY>(arg0, 9, 0x1::string::utf8(b"GTAFRIKGUY"), 0x1::string::utf8(b"pride spell"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/JJDMzORP1VpbcLUljSSofHGOAdYlEQI2szOGuMUX2KvNjoPjcDZ4p5mZ4boJ1z9fCjYC38jdUQzcTzpNxZFm-h_1ysvSa1938jzYRGuIpLUGkSSo-d0k3OxR_qd0iEOSKrPRmRuHCL_opkAJrnVyocDYNigdM4i_KXX1_c7R59iaTjInW7CSd4PsOeo73KW6tN6_gIUnESRWD7yyHr6pUR4fCjLr9e0oP4NqGygkMLuDO6-VQrIIP2wQwnkvOeZmUoJGcpfR5S2Jbr0kGYdZk5CKviEKlO79O4DqMrOTRt8m4kKt8ENFc5t6owVEPDFbOLzbmQFO8DJA68acafHKzA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTAFRIKGUY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTAFRIKGUY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

