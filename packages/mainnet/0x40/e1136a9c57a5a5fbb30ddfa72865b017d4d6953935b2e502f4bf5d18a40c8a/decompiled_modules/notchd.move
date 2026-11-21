module 0x40e1136a9c57a5a5fbb30ddfa72865b017d4d6953935b2e502f4bf5d18a40c8a::notchd {
    struct NOTCHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTCHD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a728562a626ba6bd17a5863ab8348d8b0ac73faeedc6ab42d256af856085f9dc")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a728562a626ba6bd17a5863ab8348d8b0ac73faeedc6ab42d256af856085f9dc"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NOTCHD>(arg0, 9, 0x1::string::utf8(b"NOTCHD"), 0x1::string::utf8(b"notchd"), 0x1::string::utf8(b"ntch-20 inscriptions. notchd.fun"), 0x1::string::utf8(b"https://notchd.fun/coins/notchd.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NOTCHD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOTCHD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

