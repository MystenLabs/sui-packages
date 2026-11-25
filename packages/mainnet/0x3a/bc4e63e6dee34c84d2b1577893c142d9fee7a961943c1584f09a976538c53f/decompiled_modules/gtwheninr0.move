module 0x3abc4e63e6dee34c84d2b1577893c142d9fee7a961943c1584f09a976538c53f::gtwheninr0 {
    struct GTWHENINR0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWHENINR0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWHENINR0>(arg0, 9, 0x1::string::utf8(b"GTWHENINR0"), 0x1::string::utf8(b"TOMMY"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/CyVhoyLLZ8dEYDNFOKiANbldIMTdRV7QkjmUEyYPLNQAjNhz6GEFQGhEqzSwuNKJXQZYhbN1XaA4j8rMkNNA-L3-AcdSGwpszgw8BblzCeWIHdohkDBewlYsyWi0cHeR4WSt4oVd9V9yFCQWAQhLYvEV_MnYHqWsPwuk59xjfmX5GYcw79-7BBP7S-kPZlSIyZs3cmzyQkUqy1vOKuHdc5PiACJnpJdAoy8KaZAycoN4SegWiPTe9dIo5ZediYGnFM1KzMuLqtMmW908X7RcKFaQykrlwvNiVMgpZ-JX2vmwm0oriqtN4xVm-OSl6K3idKo7Z_ZoJqxJO1F9ZcpazQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWHENINR0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWHENINR0>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

