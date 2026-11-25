module 0x1e01d785453f12ab4bb7c7ee2883af4056a9a4079eeb94ddc3147064ffeaabac::gtgoldroot {
    struct GTGOLDROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTGOLDROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTGOLDROOT>(arg0, 9, 0x1::string::utf8(b"GTGOLDROOT"), 0x1::string::utf8(b"Kleit"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/W6NoySFl2ZHU2hJ0LzxgjKj4uGDY-RAQ7lGcSt0qaGsevCBJwslGrq9lfg0NX8VHSb3-Nxw1KGgBCprbpDucpB8AX63HgPpM2e7Dm-3rfVb4MEkK91SMfFYn5XL7hEjJbx0c8kujpe6CaC8KtU3HJGS5L5cZc8CeNwk7-xle79Dh6CN37xvjFp6OrvTDN6J75t6T0TGUW-82deIRKXFwgVZbQmESviUKv_n58v3PCVq037tdrU6eJciH2gSo8IMrNca18_pLcRK5fhTC0iBmIAxOZRjCBpOfrJOWDiW4ICXjK8jDOXflIwS6UyUsRvGM3SANNWQlT0tfVlaHj26E4Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTGOLDROOT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTGOLDROOT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

