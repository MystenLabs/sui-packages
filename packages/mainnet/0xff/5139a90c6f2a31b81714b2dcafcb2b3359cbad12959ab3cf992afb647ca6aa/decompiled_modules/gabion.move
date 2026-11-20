module 0xff5139a90c6f2a31b81714b2dcafcb2b3359cbad12959ab3cf992afb647ca6aa::gabion {
    struct GABION has drop {
        dummy_field: bool,
    }

    fun init(arg0: GABION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"df4a57ae99e4767f2dfb0ae2ba1b7a6921cc417f51ebe18e05d11947182de5cc")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"df4a57ae99e4767f2dfb0ae2ba1b7a6921cc417f51ebe18e05d11947182de5cc"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GABION>(arg0, 9, 0x1::string::utf8(b"GABION"), 0x1::string::utf8(b"Gabion"), 0x1::string::utf8(b"Coins in a wire cage. gabion.cc"), 0x1::string::utf8(b"https://gabion.cc/brand/gabion-icon-512.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GABION>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GABION>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

