module 0xb0c54e9fc58a1b9c1b99f0cc21e5ecdc87a4f4c039a41672397028c5245ee1fe::raika {
    struct RAIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"0ce2aa75eb60b6b07d8ca14b5b0f0107dd7362f5a9edddbc7166e899d983fc05")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"0ce2aa75eb60b6b07d8ca14b5b0f0107dd7362f5a9edddbc7166e899d983fc05"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<RAIKA>(arg0, 9, 0x1::string::utf8(b"RAIKA"), 0x1::string::utf8(b"Raika"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/520e0c342bb564ebda0f480599bf6bb50b84e508f82467641cf5f7b6211550eb.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<RAIKA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<RAIKA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

