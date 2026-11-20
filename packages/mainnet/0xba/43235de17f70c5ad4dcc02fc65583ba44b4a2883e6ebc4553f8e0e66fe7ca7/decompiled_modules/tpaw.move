module 0xba43235de17f70c5ad4dcc02fc65583ba44b4a2883e6ebc4553f8e0e66fe7ca7::tpaw {
    struct TPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"12eafee918fc6844a12095953fb74dacb189dcbb6ff8cbf931af27f99c29d5d8")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"12eafee918fc6844a12095953fb74dacb189dcbb6ff8cbf931af27f99c29d5d8"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TPAW>(arg0, 9, 0x1::string::utf8(b"TPAW"), 0x1::string::utf8(b"Tiger Paw"), 0x1::string::utf8(b"Community meme coin for the Solar Tiger crew"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b91dc476bfd5c0698767f4d4629a4ee4a568768a13e62d3f6cb2ef8c855f3f71.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TPAW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TPAW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

