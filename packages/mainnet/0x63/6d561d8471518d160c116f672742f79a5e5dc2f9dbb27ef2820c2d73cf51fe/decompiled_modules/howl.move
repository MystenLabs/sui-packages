module 0x636d561d8471518d160c116f672742f79a5e5dc2f9dbb27ef2820c2d73cf51fe::howl {
    struct HOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HOWL>(arg0, 9, 0x1::string::utf8(b"HOWL"), 0x1::string::utf8(b"HOWL"), 0x1::string::utf8(x"546865206f776c2074686174206e6576657220736c65657073206f6e207375690a5761746368696e672065766572792063616e646c652e205061797320686f6c646572732e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/4b796376f74955bca04c0c4eb6df948c9aed7221b01d06769a37ed0ef3c9e2c5.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HOWL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HOWL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

