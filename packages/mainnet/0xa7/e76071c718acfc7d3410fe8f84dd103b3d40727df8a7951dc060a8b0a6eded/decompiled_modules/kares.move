module 0xa7e76071c718acfc7d3410fe8f84dd103b3d40727df8a7951dc060a8b0a6eded::kares {
    struct KARES has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9fb5f11bdaa413d148894d5a25f305550d09b5a78360c39adf204ca7ba7dcbc9")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9fb5f11bdaa413d148894d5a25f305550d09b5a78360c39adf204ca7ba7dcbc9"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<KARES>(arg0, 9, 0x1::string::utf8(b"KARES"), 0x1::string::utf8(b"kares"), 0x1::string::utf8(b"AresRPG token"), 0x1::string::utf8(b"https://r2.uploads.tw/2026/11/hLYCMWvi6k.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<KARES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<KARES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

