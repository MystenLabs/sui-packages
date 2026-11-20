module 0x8fab81faa88454e3386f815e64d656cce7aea4a81f74809707ae1267190612e6::taxi {
    struct TAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e63670088e75f015b71ea0815f7ef98d11d7524f60ddb0633ee1973b8b0d2cb6")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e63670088e75f015b71ea0815f7ef98d11d7524f60ddb0633ee1973b8b0d2cb6"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TAXI>(arg0, 9, 0x1::string::utf8(b"TAXI"), 0x1::string::utf8(b"Taxiway"), 0x1::string::utf8(b"Every coin waits on the taxiway. taxiway.fun"), 0x1::string::utf8(b"https://taxiway.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TAXI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TAXI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

