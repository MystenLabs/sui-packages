module 0x5612f4005e86670119b3c4d1d1639685b1a69348c229a0312284e18b51537f58::hush {
    struct HUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"82d5012c866b7fc4d05c0d36c263dddc3837e26d35e584030fc6ff2a330ef2dc")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"82d5012c866b7fc4d05c0d36c263dddc3837e26d35e584030fc6ff2a330ef2dc"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HUSH>(arg0, 9, 0x1::string::utf8(b"HUSH"), 0x1::string::utf8(b"hushkey"), 0x1::string::utf8(b"Post-quantum key checks for your wallet. hushkey.xyz"), 0x1::string::utf8(b"https://hushkey.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HUSH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HUSH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

