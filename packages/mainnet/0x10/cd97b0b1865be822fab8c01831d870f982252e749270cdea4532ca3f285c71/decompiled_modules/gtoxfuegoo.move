module 0x10cd97b0b1865be822fab8c01831d870f982252e749270cdea4532ca3f285c71::gtoxfuegoo {
    struct GTOXFUEGOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOXFUEGOO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOXFUEGOO>(arg0, 9, 0x1::string::utf8(b"GTOXFUEGOO"), 0x1::string::utf8(b"Fuego"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/DSOKoc3IzrSp2w2_mPxdpHmDMwi4zg6p2scXHfXXj3yvb7jikodU4eVUY2LYSxnUZuBkXYJnsegunoIRoci-1i36Sya218IcdI_mYsJF0SNsDb97iRL2fBr6FQdVrCk5-ilas3PeefNmuMas5vzwUpwPFhcEe4rDTtll0qz8bB12IEg-RUOCC4uNhX5sevrq13k_isR7XYzSvS0EbD-ef697Ss5QH7_i1A7JG2HL3NMZ2vBKAzQAHN8dAkcyqGTVNzj_QjHKUE-Tjf6P7VIBONqWt1BjtwDchtS0HMVg2_7F0EaM83xz_-7Z2nVpkbD57Pw66hVoNPd6Gnoi3IW5Cw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOXFUEGOO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOXFUEGOO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

