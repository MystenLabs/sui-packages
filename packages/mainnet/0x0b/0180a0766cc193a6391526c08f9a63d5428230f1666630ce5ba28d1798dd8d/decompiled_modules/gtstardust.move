module 0xb0180a0766cc193a6391526c08f9a63d5428230f1666630ce5ba28d1798dd8d::gtstardust {
    struct GTSTARDUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSTARDUST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSTARDUST>(arg0, 9, 0x1::string::utf8(b"GTSTARDUST"), 0x1::string::utf8(b"Rhinedottir"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/ixDyP_9By4hSKsKIRMlwc8py1QDL8b_hNvdIA6HG0dzDaDzauYqvQqDmJeNhZJ5fjnFFS6hfaCL5xzquY2bzdLjgRXPzqTV0ItDesFLcetf1JJ0ICh848OpoLHyOzYpE3w-NceB5bBuJEp7Oggub0grnSeBEJIcUpY0mnjxNOCrilVDs6KvGza9B9MpKtBLLR0EllZ0A1Z8hqLCJXMISpVzROvhrMVCrZx9vJg-sgzH96_8fQLCffghCaAN-ZkiNwT-z95MKTREQnlcnVlIY2dq5OVOWVPTYTIcW1ydHzfMxClbYWxghcOZz5cu9cbGloWB5L5WEcwMcOrJQH33zeg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSTARDUST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSTARDUST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

