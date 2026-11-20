module 0x7cf205e62338c961ba0360e82543fa1e9d12543fb7f4f2c868384341b1e64842::sprig {
    struct SPRIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"17251ebba4d01f14c7bbc38fbd27434639da26f65fa28936fa81f62bfa7db291")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"17251ebba4d01f14c7bbc38fbd27434639da26f65fa28936fa81f62bfa7db291"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SPRIG>(arg0, 9, 0x1::string::utf8(b"SPRIG"), 0x1::string::utf8(b"Sprig"), 0x1::string::utf8(b"Back Hyperliquid apps from your Solana wallet. When the app goes live, every trade through it pays its backers."), 0x1::string::utf8(b"https://sprig.lol/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SPRIG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SPRIG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

