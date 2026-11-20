module 0x4865c807a39bf688b93d7f5957263c20e6786e0b38ddec4ca4eaf4a32e5537f2::ticklet {
    struct TICKLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKLET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e287ef4b79847c1297e52c9c259f0f01de4dbee385fc33773bf31a136c94c8cb")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e287ef4b79847c1297e52c9c259f0f01de4dbee385fc33773bf31a136c94c8cb"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TICKLET>(arg0, 9, 0x1::string::utf8(b"TICKLET"), 0x1::string::utf8(b"Ticklet"), 0x1::string::utf8(b"Meme coins paired with stock tokens. ticklet.xyz"), 0x1::string::utf8(b"https://ticklet.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TICKLET>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TICKLET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

