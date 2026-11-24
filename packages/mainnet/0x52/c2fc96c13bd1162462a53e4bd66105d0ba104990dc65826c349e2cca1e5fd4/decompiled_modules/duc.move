module 0x52c2fc96c13bd1162462a53e4bd66105d0ba104990dc65826c349e2cca1e5fd4::duc {
    struct DUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<DUC>(arg0, 9, 0x1::string::utf8(b"DUC"), 0x1::string::utf8(b"DUC"), 0x1::string::utf8(x"5468652064756d62657374206475636b206f6e205375692e205a65726f2049512c20756e6c696d6974656420636f6e666964656e63652e204e6f20706c616e732c206e6f20627261696e732c206a75737420717561636b696e6720616e6420766962696e672e20f09fa686"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d5b5bf4cfe13a05960625a23ab56eb545bb27c0f56986ff9b3832d28dbedef5a.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<DUC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DUC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

