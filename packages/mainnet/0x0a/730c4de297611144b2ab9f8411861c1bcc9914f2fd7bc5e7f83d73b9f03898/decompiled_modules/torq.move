module 0xa730c4de297611144b2ab9f8411861c1bcc9914f2fd7bc5e7f83d73b9f03898::torq {
    struct TORQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e5dd4c6427eb22dc546b4d6b351d8a403bdd9bb0a1c8412648bb8d0501ac1eef")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e5dd4c6427eb22dc546b4d6b351d8a403bdd9bb0a1c8412648bb8d0501ac1eef"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TORQ>(arg0, 9, 0x1::string::utf8(b"TORQ"), 0x1::string::utf8(b"Torque"), 0x1::string::utf8(b"Torque on Robinhood Chain. torqcrew.fun"), 0x1::string::utf8(b"https://torqcrew.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TORQ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TORQ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

