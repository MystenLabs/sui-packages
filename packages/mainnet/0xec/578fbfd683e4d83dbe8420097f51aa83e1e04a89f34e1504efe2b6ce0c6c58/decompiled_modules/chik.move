module 0xec578fbfd683e4d83dbe8420097f51aa83e1e04a89f34e1504efe2b6ce0c6c58::chik {
    struct CHIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"0ce2aa75eb60b6b07d8ca14b5b0f0107dd7362f5a9edddbc7166e899d983fc05")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"0ce2aa75eb60b6b07d8ca14b5b0f0107dd7362f5a9edddbc7166e899d983fc05"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CHIK>(arg0, 9, 0x1::string::utf8(b"CHIK"), 0x1::string::utf8(b"ChickCoin"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/cc2cc01e56e5e78d5d9252fd10b6ca75a1dcb8ad54f7df0d1a88d4b25394b46a.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CHIK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CHIK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

