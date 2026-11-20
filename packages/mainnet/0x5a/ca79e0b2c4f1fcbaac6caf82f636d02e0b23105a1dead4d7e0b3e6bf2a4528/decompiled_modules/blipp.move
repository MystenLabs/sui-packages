module 0x5aca79e0b2c4f1fcbaac6caf82f636d02e0b23105a1dead4d7e0b3e6bf2a4528::blipp {
    struct BLIPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIPP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"ebe35686e4c4af7db68788717807ed74a4cb04ea98929f52019b1a05f1acb753")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"ebe35686e4c4af7db68788717807ed74a4cb04ea98929f52019b1a05f1acb753"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLIPP>(arg0, 9, 0x1::string::utf8(b"BLIPP"), 0x1::string::utf8(b"blipp"), 0x1::string::utf8(b"blip-20 inscriptions. every ticker can only be claimed once. blipp.fun"), 0x1::string::utf8(b"https://blipp.fun/brand/icon-512.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLIPP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLIPP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

