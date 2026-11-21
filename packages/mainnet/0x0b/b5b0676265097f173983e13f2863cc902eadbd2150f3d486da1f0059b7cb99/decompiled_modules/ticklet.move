module 0xbb5b0676265097f173983e13f2863cc902eadbd2150f3d486da1f0059b7cb99::ticklet {
    struct TICKLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKLET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e36d6540bfc2ebde438793fd9f8a8b6bab8d0f78c916928eee5fa804ce48c2dc")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e36d6540bfc2ebde438793fd9f8a8b6bab8d0f78c916928eee5fa804ce48c2dc"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TICKLET>(arg0, 9, 0x1::string::utf8(b"TICKLET"), 0x1::string::utf8(b"Ticklet"), 0x1::string::utf8(b"Meme coins paired with stock tokens. ticklet.xyz"), 0x1::string::utf8(b"https://ticklet.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TICKLET>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TICKLET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

