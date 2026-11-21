module 0x94bcbc654e4356630804efebbde1620242b6cd9cbc92a2aa4189bd6ed87bcd58::sprig {
    struct SPRIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a87b5e8c976e85deea5733ef115356a7fc79c6cd0fad4acfcfc6ea3aadc345a9")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a87b5e8c976e85deea5733ef115356a7fc79c6cd0fad4acfcfc6ea3aadc345a9"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SPRIG>(arg0, 9, 0x1::string::utf8(b"SPRIG"), 0x1::string::utf8(b"Sprig"), 0x1::string::utf8(b"Back Hyperliquid apps from your Solana wallet. When the app goes live, every trade through it pays its backers."), 0x1::string::utf8(b"https://sprig.lol/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SPRIG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SPRIG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

