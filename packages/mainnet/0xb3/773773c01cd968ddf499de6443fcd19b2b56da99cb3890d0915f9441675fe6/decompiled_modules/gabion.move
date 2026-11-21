module 0xb3773773c01cd968ddf499de6443fcd19b2b56da99cb3890d0915f9441675fe6::gabion {
    struct GABION has drop {
        dummy_field: bool,
    }

    fun init(arg0: GABION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"12f1ffa03a2ab37be65e380972edad52012dd19055c9998e7a3a3085f8610027")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"12f1ffa03a2ab37be65e380972edad52012dd19055c9998e7a3a3085f8610027"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GABION>(arg0, 9, 0x1::string::utf8(b"GABION"), 0x1::string::utf8(b"Gabion"), 0x1::string::utf8(b"Coins in a wire cage. gabion.cc"), 0x1::string::utf8(b"https://gabion.cc/brand/gabion-icon-512.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GABION>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GABION>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

