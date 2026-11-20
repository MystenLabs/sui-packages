module 0x9515b123b02d6c3ce5a290d68e2e78de4211a037ae537412e387a54970954a76::hush {
    struct HUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"ba5ef2ec8e8ce39336a5cda9a3d976b586d66555020522fc7beec19635ef06f3")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"ba5ef2ec8e8ce39336a5cda9a3d976b586d66555020522fc7beec19635ef06f3"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HUSH>(arg0, 9, 0x1::string::utf8(b"HUSH"), 0x1::string::utf8(b"hushkey"), 0x1::string::utf8(b"Post-quantum key checks for your wallet. hushkey.xyz"), 0x1::string::utf8(b"https://hushkey.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HUSH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HUSH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

