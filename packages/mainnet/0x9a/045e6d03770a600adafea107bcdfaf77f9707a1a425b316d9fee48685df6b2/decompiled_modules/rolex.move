module 0x9a045e6d03770a600adafea107bcdfaf77f9707a1a425b316d9fee48685df6b2::rolex {
    struct ROLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"0ffbacb5654d3603f49bc19e8ecee4d28c0632b3b7783bd76ea1652c7ef78d4c")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"0ffbacb5654d3603f49bc19e8ecee4d28c0632b3b7783bd76ea1652c7ef78d4c"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ROLEX>(arg0, 9, 0x1::string::utf8(b"ROLEX"), 0x1::string::utf8(b"Rolex"), 0x1::string::utf8(x"486f70696e6720746869732077696c6c20627579206d65206120526f6c6578207761746368200a4974e280997320616c77617973206265656e206d7920647265616d"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/60251b06cc5496391fd06dded5543aadafadb95a1b35e91cfc53741c8ae8bcb1.webp"), v0, false, 2000, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ROLEX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ROLEX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

