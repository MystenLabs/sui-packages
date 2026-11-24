module 0x6c29d7850133b83f8358fc92e67ff27f5efb1c981e79643ca3351a75d40314cd::elyw {
    struct ELYW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELYW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ELYW>(arg0, 9, 0x1::string::utf8(b"ELYW"), 0x1::string::utf8(b"ELYW"), 0x1::string::utf8(x"45796573206f6e207375690a547261636b2065766572797468696e672e204d697373206e6f7468696e672e0a5061797320686f6c646572732e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/392bd3c6cd3b9ec0c8cd9d7b52c1c5ff3df2599400c7cf604d1362e1f1d01678.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ELYW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ELYW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

