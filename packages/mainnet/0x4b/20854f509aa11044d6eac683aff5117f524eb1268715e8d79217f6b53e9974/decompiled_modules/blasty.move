module 0x4b20854f509aa11044d6eac683aff5117f524eb1268715e8d79217f6b53e9974::blasty {
    struct BLASTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"0ec50de4c7fbf5b8ac34df44da8fba339af02f6c83ba82cefd786065644d89a3")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"0ec50de4c7fbf5b8ac34df44da8fba339af02f6c83ba82cefd786065644d89a3"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLASTY>(arg0, 9, 0x1::string::utf8(b"BLASTY"), 0x1::string::utf8(b"Blasty"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/42b6545f02004f2e4eec465e19b7edbf8676f806cac7fb17540f9d8b67c47caa.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLASTY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLASTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

