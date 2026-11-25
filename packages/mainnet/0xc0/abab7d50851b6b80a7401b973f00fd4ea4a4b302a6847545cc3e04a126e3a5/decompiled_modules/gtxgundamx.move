module 0xc0abab7d50851b6b80a7401b973f00fd4ea4a4b302a6847545cc3e04a126e3a5::gtxgundamx {
    struct GTXGUNDAMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTXGUNDAMX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTXGUNDAMX>(arg0, 9, 0x1::string::utf8(b"GTXGUNDAMX"), 0x1::string::utf8(b"Gundam"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Rr65Emf0Kze8Bp_XYRr3FIfRIm8764eb68sDaPCsppMSj5f_SDt1InhSx64kKpMQqSz1u6xv6HcnLMfXy5nO-25YVL18AUp8DXnB4F13NCwsPShyQt7v_OwwSVyUH0fBcd9lh9fDv3D_Ln7WkHmigv9VglzW92SVOuiXxmaWDvltMBokqlBIU36DImAAxcaAjpnWkKNjLIzwV9ncgbJ7jkSELcQsuYn4O7BQVfJaIp_tBh2CVcsPYqm2Q-fSKpoi7afODfLOgbHvGrnGxVyb5pBcAtu0tzQOrKcx4QmJIRil_9g4-ynBIYbI8Iop75TLvpTx61waCsfFeJVmEWMTow.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTXGUNDAMX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTXGUNDAMX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

