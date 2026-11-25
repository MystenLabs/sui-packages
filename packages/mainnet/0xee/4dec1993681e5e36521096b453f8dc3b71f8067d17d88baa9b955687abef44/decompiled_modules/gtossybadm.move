module 0xee4dec1993681e5e36521096b453f8dc3b71f8067d17d88baa9b955687abef44::gtossybadm {
    struct GTOSSYBADM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOSSYBADM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOSSYBADM>(arg0, 9, 0x1::string::utf8(b"GTOSSYBADM"), 0x1::string::utf8(b"ossy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/DqYFNmR-QxZQEqkObqwUvHk-YqyrDW9145mE78XS0I_IdvG7DBwsY4FuQPfbotDqCq1bg9UtTdGbOJUQqeqoHsjj7rRDuPXbavlo0X-Pf77_GW2yW364bfAi5iiW6XhSWK5bN2aQkO0Rqfr9zr0xN-OQK9QcH8sbj7r8kH5u0TsKWD6Zvf1k7U9aYGY-yGnkJ2g3Tt4km0LfXWBUVIp0bTn17qjmBWwEVlEVZEkV954K4TjyOZkgCA2wQv2060uhr2V8bva6TIw_TSdwevLlJ2m_a8pmzeEi8m-x-0et5ztRrdFYpegmvotVa1OrUtefp9FSIEGlQaae4WgIjcEC9w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOSSYBADM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOSSYBADM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

