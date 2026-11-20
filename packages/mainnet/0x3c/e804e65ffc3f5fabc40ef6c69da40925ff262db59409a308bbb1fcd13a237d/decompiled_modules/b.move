module 0x3ce804e65ffc3f5fabc40ef6c69da40925ff262db59409a308bbb1fcd13a237d::b {
    struct B has drop {
        dummy_field: bool,
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"bc0f779188ede1b36bf367bea7657eacd2cdc28df7412db2143989407f5f2acd")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"bc0f779188ede1b36bf367bea7657eacd2cdc28df7412db2143989407f5f2acd"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<B>(arg0, 9, 0x1::string::utf8(b"B"), 0x1::string::utf8(b"The B"), 0x1::string::utf8(b"Only press"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/8543c840dc991d2eac01efed53c2e65bcafa8b35fac008f657a7b5dbe5aef705.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<B>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<B>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

