module 0x7610defe4840deb0b1e4ca8e2f79c1a7e5928f040218589af6b67c792607608e::wws {
    struct WWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"507be0ca492032aa0044435819fc36fe6429347bbf24794af2e8b9674f1553f9")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"507be0ca492032aa0044435819fc36fe6429347bbf24794af2e8b9674f1553f9"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<WWS>(arg0, 9, 0x1::string::utf8(b"WWS"), 0x1::string::utf8(b"we will survive"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/8d1b1a9c3651354a35a9f2597da54a41c2aafffd195873a6df946590f22854a6.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<WWS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<WWS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

