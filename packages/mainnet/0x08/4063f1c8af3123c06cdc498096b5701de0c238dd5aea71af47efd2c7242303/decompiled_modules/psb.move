module 0x84063f1c8af3123c06cdc498096b5701de0c238dd5aea71af47efd2c7242303::psb {
    struct PSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"59ac82517df21ce4cc5cd01b6921c4ae9c63323b6f34a1f6ee4355316d5fcb20")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"59ac82517df21ce4cc5cd01b6921c4ae9c63323b6f34a1f6ee4355316d5fcb20"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PSB>(arg0, 9, 0x1::string::utf8(b"PSB"), 0x1::string::utf8(b"PressB"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a972c5007b940ed1d9984ad36ddad304814dda9036d89b5d71bf5448db254a78.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PSB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PSB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

