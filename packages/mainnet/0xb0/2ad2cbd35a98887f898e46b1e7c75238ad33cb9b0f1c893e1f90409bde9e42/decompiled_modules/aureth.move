module 0xb02ad2cbd35a98887f898e46b1e7c75238ad33cb9b0f1c893e1f90409bde9e42::aureth {
    struct AURETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURETH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e52aa8a77a4d06c53d7681090d02823d23f77de9d07d7ace044c56022077226b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e52aa8a77a4d06c53d7681090d02823d23f77de9d07d7ace044c56022077226b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<AURETH>(arg0, 9, 0x1::string::utf8(b"AURETH"), 0x1::string::utf8(b"Aureth"), 0x1::string::utf8(b"Ideas meet liquidity."), 0x1::string::utf8(b"https://aureth-meta.vercel.app/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<AURETH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<AURETH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

