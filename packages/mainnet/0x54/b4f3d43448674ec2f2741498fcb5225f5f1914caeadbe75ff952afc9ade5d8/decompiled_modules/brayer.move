module 0x54b4f3d43448674ec2f2741498fcb5225f5f1914caeadbe75ff952afc9ade5d8::brayer {
    struct BRAYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAYER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"34e222d54e6abab2bead15b56ab9367d95cd24bc1dbcbb3aea7025248680785c")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"34e222d54e6abab2bead15b56ab9367d95cd24bc1dbcbb3aea7025248680785c"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BRAYER>(arg0, 9, 0x1::string::utf8(b"BRAYER"), 0x1::string::utf8(b"Brayer"), 0x1::string::utf8(b"House coin of Brayer. brayer.xyz"), 0x1::string::utf8(b"https://brayer.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BRAYER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BRAYER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

