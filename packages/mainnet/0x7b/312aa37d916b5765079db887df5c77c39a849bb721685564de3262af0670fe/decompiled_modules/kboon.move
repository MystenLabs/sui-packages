module 0x7b312aa37d916b5765079db887df5c77c39a849bb721685564de3262af0670fe::kboon {
    struct KBOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"8d4fc3f9f695753e813579846266d5ded5e663669e109988c2055ac29e5095f6")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"8d4fc3f9f695753e813579846266d5ded5e663669e109988c2055ac29e5095f6"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<KBOON>(arg0, 9, 0x1::string::utf8(b"KBOON"), 0x1::string::utf8(b"KaBoon"), 0x1::string::utf8(b"Suiperhero Kevin KaBoon"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/3250fb0e7caa99dc477fcb2cc767789630fad857f6fe4e65538777261b58447c.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<KBOON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<KBOON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

