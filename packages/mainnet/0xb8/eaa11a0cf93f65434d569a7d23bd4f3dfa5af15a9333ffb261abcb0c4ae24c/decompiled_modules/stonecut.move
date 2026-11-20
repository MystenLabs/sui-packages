module 0xb8eaa11a0cf93f65434d569a7d23bd4f3dfa5af15a9333ffb261abcb0c4ae24c::stonecut {
    struct STONECUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONECUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"15796817ce54c501fd59831a1ecf3924478607477b7a9d820f01294b9c4b5b79")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"15796817ce54c501fd59831a1ecf3924478607477b7a9d820f01294b9c4b5b79"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<STONECUT>(arg0, 9, 0x1::string::utf8(b"STONECUT"), 0x1::string::utf8(b"Stonecut"), 0x1::string::utf8(b"Cut a coin into stone. stonecut.fun"), 0x1::string::utf8(b"https://stonecut.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<STONECUT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<STONECUT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

