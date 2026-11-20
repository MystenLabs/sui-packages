module 0x971294750870706c72b4cbc24ade85114aaff1980c5d8fce1ce3f7583b48a675::stonecut {
    struct STONECUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONECUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"d1766c40d45c0fbfc8c090d0064b8c1235d4a52cf26887d22d8cee1d062970cd")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"d1766c40d45c0fbfc8c090d0064b8c1235d4a52cf26887d22d8cee1d062970cd"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<STONECUT>(arg0, 9, 0x1::string::utf8(b"STONECUT"), 0x1::string::utf8(b"Stonecut"), 0x1::string::utf8(b"Cut a coin into stone. stonecut.fun"), 0x1::string::utf8(b"https://stonecut.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<STONECUT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<STONECUT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

