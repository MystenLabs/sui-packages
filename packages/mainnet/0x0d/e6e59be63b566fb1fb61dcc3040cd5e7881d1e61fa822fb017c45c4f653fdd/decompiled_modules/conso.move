module 0xde6e59be63b566fb1fb61dcc3040cd5e7881d1e61fa822fb017c45c4f653fdd::conso {
    struct CONSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONSO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f196862fac2614f85d69c5c99218c1af3edaaccc713c8c41dc604bd6f7238d26")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f196862fac2614f85d69c5c99218c1af3edaaccc713c8c41dc604bd6f7238d26"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CONSO>(arg0, 9, 0x1::string::utf8(b"CONSO"), 0x1::string::utf8(b"conso"), 0x1::string::utf8(x"436f6e73756d657220477261706820616e64205061796d656e74730a0a506f7765726564206279204057616c72757350726f746f636f6c"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/735ac74afc2c7f6548f85d3386a5e5a0041426160b8ee575076488e03a1e27f4.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CONSO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CONSO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

