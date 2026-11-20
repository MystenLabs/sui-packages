module 0xa0eb72b158835fb2049cf94e02f50a70cf8bb5504123f8ad05c694dbb29927de::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"450c86a8ea567c48165150f54e4b9c5106db1553b89bba95eced3f011280389b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"450c86a8ea567c48165150f54e4b9c5106db1553b89bba95eced3f011280389b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLAST>(arg0, 9, 0x1::string::utf8(b"BLAST"), 0x1::string::utf8(b"blast"), 0x1::string::utf8(b"Blast Token"), 0x1::string::utf8(b"https://r2.uploads.tw/2026/11/JrgFuzutqy.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLAST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLAST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

