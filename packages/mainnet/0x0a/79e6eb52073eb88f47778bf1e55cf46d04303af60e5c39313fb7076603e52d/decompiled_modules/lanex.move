module 0xa79e6eb52073eb88f47778bf1e55cf46d04303af60e5c39313fb7076603e52d::lanex {
    struct LANEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"d9d07e1e4d669f82cab464ffa06eab7d08f22a5e6d949c44bd0ef0d7d8066e16")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"d9d07e1e4d669f82cab464ffa06eab7d08f22a5e6d949c44bd0ef0d7d8066e16"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LANEX>(arg0, 9, 0x1::string::utf8(b"LANEX"), 0x1::string::utf8(b"Lanex"), 0x1::string::utf8(b"Open market for AI inference. Sellers list GPU time, buyers pay per call, every receipt is signed."), 0x1::string::utf8(b"https://lanexai.xyz/x/x-pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LANEX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LANEX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

