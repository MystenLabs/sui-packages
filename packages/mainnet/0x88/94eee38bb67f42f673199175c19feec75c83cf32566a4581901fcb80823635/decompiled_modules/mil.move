module 0x8894eee38bb67f42f673199175c19feec75c83cf32566a4581901fcb80823635::mil {
    struct MIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"2e8a93b8c6c430cee03e435a56723b1a500577b4e5d7ac19d94a01ba45f65871")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"2e8a93b8c6c430cee03e435a56723b1a500577b4e5d7ac19d94a01ba45f65871"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MIL>(arg0, 9, 0x1::string::utf8(b"MIL"), 0x1::string::utf8(b"Mili"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f9319186c26b027231d1d679a778c546874888a832ce5251a2b18463260406bd.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MIL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MIL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

