module 0x857f651570cab2cbdecd03f4dcc526cca49ea0ee6a015ad28e302cd310e273b5::gtjbias0x {
    struct GTJBIAS0X has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJBIAS0X, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJBIAS0X>(arg0, 9, 0x1::string::utf8(b"GTJBIAS0X"), 0x1::string::utf8(b"Jesse"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/Y3MMxKg5aypPOudSsxjeJV3A04t5Gs2pZFOLnNBRJo3psKPEk5nyCD746PzEFU2uiQx_R45Ha_JZJPlyMBo46c3DoBuJ7TcWBCST2Np5I8xNDgLQNqQecpTKJCUg0DagonHPHKGywDCmrx24XFIunz0X6yrdBOFN7-fIoKrUYYXPzOoNarUQHwmc0aBIHTwK0tPA4u_K9x1pT0uDc43MQfhTB104ictRDfa_AOwRBPFEdKEQhtJZ8qHVzLiklaZaL1022NvobIcsU7KbiheMAJdOF_uiGUUWXHMIGZTtT7UXvJ2H1WkxDwvUmefYYE2uX0ZDbrDC-SePkohJZ9e1dA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJBIAS0X>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJBIAS0X>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

