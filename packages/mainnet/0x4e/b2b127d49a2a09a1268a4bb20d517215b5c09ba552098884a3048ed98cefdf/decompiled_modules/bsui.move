module 0x4eb2b127d49a2a09a1268a4bb20d517215b5c09ba552098884a3048ed98cefdf::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3b056354f0d2f333f36b5b2654d94fb1206e749d9cb20b738e590e45d1e9eb01")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3b056354f0d2f333f36b5b2654d94fb1206e749d9cb20b738e590e45d1e9eb01"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BSUI>(arg0, 9, 0x1::string::utf8(b"BSUI"), 0x1::string::utf8(b"Blast Sui"), 0x1::string::utf8(b"Not your ordinary ALTCOIN, made for SUI, to SUI, by SUI"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f6aaf6e3a0a11fa7ffddd656f1b91a03cca271ad38c359626bf03367f49471c3.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

