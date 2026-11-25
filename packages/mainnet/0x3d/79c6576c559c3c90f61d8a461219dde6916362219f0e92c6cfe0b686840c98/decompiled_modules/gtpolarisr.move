module 0x3d79c6576c559c3c90f61d8a461219dde6916362219f0e92c6cfe0b686840c98::gtpolarisr {
    struct GTPOLARISR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPOLARISR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPOLARISR>(arg0, 9, 0x1::string::utf8(b"GTPOLARISR"), 0x1::string::utf8(b"Kim Nina"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Qzi5iZ6BPLmRJwMLLqCKkb1h0isW7tRCOG4gXwAW8J7--uwccx3yRhWSdv_e4fXgHxVb9L1LW4xMDQowvRqiUWvLi9WKj1ZxpTplZonissTu65hp7FeCHByq4y0tk4HBplBsDwY9jCjJJoFyj4DEVpGetd32-gkBIR4nAUJIWp1u2nG4Q6O44yllVZI4kGMF1u74C9-8g0575QxTj7zkoRdSlMXysiMxBj7u5euVrEZz6Qis4olywOrJTE0Zz7K_J8NJMZ7I0tP_uUs6qd0Rwd-bxw3W0B4rsqjDC8urTTSwYgi12CpyxMiSo7r3afIetO_NEY9kfdLsEBi4xyBBxA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPOLARISR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPOLARISR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

