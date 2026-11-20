module 0xdf11450aa7c3b1b9b2079bcec6a3c0a428b1f35d1bb87ca35ad09bc59b61f227::ct {
    struct CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"84e11c8cfc66c82e2d62fa3141337d44653aff5e0d199ef83245c0764d858902")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"84e11c8cfc66c82e2d62fa3141337d44653aff5e0d199ef83245c0764d858902"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CT>(arg0, 9, 0x1::string::utf8(b"CT"), 0x1::string::utf8(b"Cati"), 0x1::string::utf8(b"one cat one token"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a6c76942862371cb93abce022854f87a5c6eed44fcbe0a162315846434df3248.webp"), v0, true, 5000, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

