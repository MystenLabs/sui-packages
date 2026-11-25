module 0x1419ecb45413495e178bcf3b6579521b9fd442622184a80d26f7c796207b5e6b::gtcookiepu {
    struct GTCOOKIEPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCOOKIEPU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCOOKIEPU>(arg0, 9, 0x1::string::utf8(b"GTCOOKIEPU"), 0x1::string::utf8(b"Cookie Puss"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/Q_T9rMdcKLLRMT6WmNhY2-P3RuQ-xsggDt8oZAtoDzqImNGoMWdYs9CvAlJd7AchUSD9w18LQBbEgvU9zwfzJ2fg5G5SPDOclbuaY9wHbH3W5f7OIf1cJR2rAzKJK5gX2spgekrUhkYURPLtkgTePKzOtQERNZgK0On5rGtCSxfBmO8qG-FcZ7Cn1OIjGTsZK_LENy07B2-OMsKwVZF8H1ZggWIK2PqO9o5cdlqi4qR4ylBumcIFGx9K9NXmVIzOCA_ZM6TPvHnNbjk3brnlk63yfP10xG8oIQncRATa-LUusLNUO3FoXZ12AvdhgrDkdfkm09cKJthYJW0cIKx8Yw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCOOKIEPU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCOOKIEPU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

