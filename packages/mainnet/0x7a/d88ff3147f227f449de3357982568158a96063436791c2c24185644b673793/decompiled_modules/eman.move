module 0x7ad88ff3147f227f449de3357982568158a96063436791c2c24185644b673793::eman {
    struct EMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"59ac82517df21ce4cc5cd01b6921c4ae9c63323b6f34a1f6ee4355316d5fcb20")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"59ac82517df21ce4cc5cd01b6921c4ae9c63323b6f34a1f6ee4355316d5fcb20"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<EMAN>(arg0, 9, 0x1::string::utf8(b"EMAN"), 0x1::string::utf8(b"EMAN"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/08972e355be563bdad54e21d80c4ef82a31adb2bf7c5c3bed048be7c5ca1b5b7.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<EMAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<EMAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

