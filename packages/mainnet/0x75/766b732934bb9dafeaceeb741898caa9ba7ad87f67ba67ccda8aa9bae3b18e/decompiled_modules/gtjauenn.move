module 0x75766b732934bb9dafeaceeb741898caa9ba7ad87f67ba67ccda8aa9bae3b18e::gtjauenn {
    struct GTJAUENN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJAUENN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJAUENN>(arg0, 9, 0x1::string::utf8(b"GTJAUENN"), 0x1::string::utf8(b"Jauen"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/XRY8zxsMlWaktlnkxengyZQZ7RB9FcnqEOC3gPHdoORuC-BlSenUiiN1NRSUglcmR2aS52sBErvvJZdB8JlISTZ2GXpW8sTTCVxoWZTAz0fK4mUqgw79XZLaJo0azpr3n4vBTBwfksQxM80R_HsqL4nlScxem3nHNuSLcOEwsq_nudsOQ7dFgqK0KtaURksmpR34eBGSN9iwyh7pBkwQiJ_1aZIdxF6GiQR37HrUIaXvgT_mY5g-ZKKqY9UZK8x56wJ2zFPA0Ho82M9EvCgFP3b0MOYJNtmhyyvyq2IkHKZTi7gVMJgEN6pH39fNo0NKuN5cyBKPxpta5UeKVeAEhA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJAUENN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJAUENN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

