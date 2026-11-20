module 0xbee847a177863114a4577101265808cfd2289ed5df787be8cf250dd04022bdb1::ecash {
    struct ECASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECASH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"42cf9c38152e87de4c36e683782fc7bd1e5920511d352352e639447a6cb1e433")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"42cf9c38152e87de4c36e683782fc7bd1e5920511d352352e639447a6cb1e433"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ECASH>(arg0, 9, 0x1::string::utf8(b"ECASH"), 0x1::string::utf8(b"ecash"), 0x1::string::utf8(b"ecash"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/6179a6012a927a9e73e31b4c5a59f96e966d015d2caebbfef301dc20d921aad6.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ECASH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ECASH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

