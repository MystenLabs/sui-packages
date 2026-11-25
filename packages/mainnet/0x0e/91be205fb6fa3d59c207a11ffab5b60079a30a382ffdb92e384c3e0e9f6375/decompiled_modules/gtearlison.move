module 0xe91be205fb6fa3d59c207a11ffab5b60079a30a382ffdb92e384c3e0e9f6375::gtearlison {
    struct GTEARLISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTEARLISON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTEARLISON>(arg0, 9, 0x1::string::utf8(b"GTEARLISON"), 0x1::string::utf8(b"EARLISON .sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Vow2pJuMzMBwgn6l8Cf3YWEBzJiGP-09GohgKWdvTfhYWfnoCfjLcPD62yRCI1hpdvGRzW9uTLbVR6XFqPDpIsvgccEgWhEfvlB4oUxN1w-PE17-digdD9ixhKhU7j34BrjoCmTdRKTlDu-ORMXQvm5badrUI_F3Zq9fIHYNmXyGw6050_fw1CT-DysuZeUfb4WHpYiM3irZDMH4NDW3SaEBxEPrpJUALVEbzgZcEAPP5xju6vulGfEhkDsmAjRdV7dkv5rT6JuWAVfVCM6Y36EQ439wfvAyHCjSOo9OI0J3yhoPdoPdq0R-Mpj66ISqe38TLPn9ut3-K9VTBRvwuQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTEARLISON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTEARLISON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

