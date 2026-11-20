module 0x2f977f3c2f3cd478d4674711679aac44fd4a818825d73ef92aad1cad84d675b5::cat6 {
    struct CAT6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT6, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"b41eebab462a495a83b4436e2ef381abe24c4ab14dc8d83e42ba79e4255ff8a4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"b41eebab462a495a83b4436e2ef381abe24c4ab14dc8d83e42ba79e4255ff8a4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CAT6>(arg0, 9, 0x1::string::utf8(b"CAT6"), 0x1::string::utf8(b"Cat city"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/3859be31f58f76e185701b9988920c29b34f62623a9482d32f5fbd8820c617bc.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CAT6>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CAT6>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

