module 0xc4f2ab55d62679c0171c0441459441823cf4d709a8b5e3c918cc5003f7fac1b6::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"2cf4deb0afcd6da11bc713da50bf22a7d381f9e7c41644c61f921f43978e844d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"2cf4deb0afcd6da11bc713da50bf22a7d381f9e7c41644c61f921f43978e844d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HONEY>(arg0, 9, 0x1::string::utf8(b"HONEY"), 0x1::string::utf8(b"Honeyframe"), 0x1::string::utf8(b"Presales that fill like a honeycomb. honeyframe.xyz"), 0x1::string::utf8(b"https://honeyframe.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HONEY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HONEY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

