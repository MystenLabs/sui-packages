module 0xc9a059c0ef59b2b861306d810ebd00b58471f1c89dd9fcc7e1d400cbaf7a381b::wicket {
    struct WICKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"6f86afce356800c4dc0d287f9a0ded5d28ef789aca0fe3015b3fee3a41533acf")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"6f86afce356800c4dc0d287f9a0ded5d28ef789aca0fe3015b3fee3a41533acf"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<WICKET>(arg0, 9, 0x1::string::utf8(b"WICKET"), 0x1::string::utf8(b"Skywicket"), 0x1::string::utf8(b"Launch through the wicket. skywicket.lol"), 0x1::string::utf8(b"https://skywicket.lol/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<WICKET>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<WICKET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

