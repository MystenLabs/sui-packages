module 0xda2e3f56ae611c4ed24ecb34928e8e23a830d0fedf71657db7eee54a6462f1a1::conso {
    struct CONSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONSO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"d9c89251b37a961665eea3e5ff4e639b0fc77c1ff37f29e50c334008e86a9d6d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"d9c89251b37a961665eea3e5ff4e639b0fc77c1ff37f29e50c334008e86a9d6d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CONSO>(arg0, 9, 0x1::string::utf8(b"CONSO"), 0x1::string::utf8(b"Conso"), 0x1::string::utf8(b"hype on sui"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/456f2357f0738f471981ae004f95a50b94ffc35317cfeb89d22e48c0c3f3f091.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CONSO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CONSO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

