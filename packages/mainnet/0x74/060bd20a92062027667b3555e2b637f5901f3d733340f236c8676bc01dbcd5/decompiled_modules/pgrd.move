module 0x74060bd20a92062027667b3555e2b637f5901f3d733340f236c8676bc01dbcd5::pgrd {
    struct PGRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"06358df1383ba68247f0aaac5461caaa5b50c29ab681c162e2c037c56d8b9981")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"06358df1383ba68247f0aaac5461caaa5b50c29ab681c162e2c037c56d8b9981"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PGRD>(arg0, 9, 0x1::string::utf8(b"PGRD"), 0x1::string::utf8(b"Pregrade"), 0x1::string::utf8(b"Token presales on Robinhood Chain, graded before you buy. pregrade.fun"), 0x1::string::utf8(b"https://pregrade.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PGRD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PGRD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

