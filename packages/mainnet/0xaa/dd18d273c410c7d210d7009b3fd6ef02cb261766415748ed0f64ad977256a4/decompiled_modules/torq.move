module 0xaadd18d273c410c7d210d7009b3fd6ef02cb261766415748ed0f64ad977256a4::torq {
    struct TORQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"8f00524d9e0bc161cfc387578f3f291ea4c46dbda6741b21ee730d51d067fc18")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"8f00524d9e0bc161cfc387578f3f291ea4c46dbda6741b21ee730d51d067fc18"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TORQ>(arg0, 9, 0x1::string::utf8(b"TORQ"), 0x1::string::utf8(b"Torque"), 0x1::string::utf8(b"Torque on Robinhood Chain. torqcrew.fun"), 0x1::string::utf8(b"https://torqcrew.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TORQ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TORQ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

