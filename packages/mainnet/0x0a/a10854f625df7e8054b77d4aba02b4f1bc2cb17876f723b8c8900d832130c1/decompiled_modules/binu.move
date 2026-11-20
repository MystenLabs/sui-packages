module 0xaa10854f625df7e8054b77d4aba02b4f1bc2cb17876f723b8c8900d832130c1::binu {
    struct BINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"dce91c370db7451e348b7bdbb41df8e645e1e26922aebcd1f3c54bd3996e4f92")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"dce91c370db7451e348b7bdbb41df8e645e1e26922aebcd1f3c54bd3996e4f92"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BINU>(arg0, 9, 0x1::string::utf8(b"BINU"), 0x1::string::utf8(b"Blast Inu"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/57cb2f807ab31d22e6b938aa746873991598e69d9f178bf64c8eb936d6def091.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BINU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BINU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

