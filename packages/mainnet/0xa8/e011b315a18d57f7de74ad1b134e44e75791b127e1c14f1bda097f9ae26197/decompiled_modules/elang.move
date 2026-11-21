module 0xa8e011b315a18d57f7de74ad1b134e44e75791b127e1c14f1bda097f9ae26197::elang {
    struct ELANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELANG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f17d620429d3aad451285d012018a56251b0e7293c84510e0355b29579ae4f6a")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f17d620429d3aad451285d012018a56251b0e7293c84510e0355b29579ae4f6a"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ELANG>(arg0, 9, 0x1::string::utf8(b"ELANG"), 0x1::string::utf8(b"ELANG AI"), 0x1::string::utf8(b"An eagle-eyed coin launchpad. elang.world"), 0x1::string::utf8(b"https://elang.world/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ELANG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ELANG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

