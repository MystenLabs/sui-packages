module 0x4a74789e6e077c8097fd01f34d8f09c446c01ae52aebe3709d26cf9d532341a8::cad {
    struct CAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"c8253700f57639e1df0a1eaaea2be63c28b911c16799b79587ed4ff92e11c4de")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"c8253700f57639e1df0a1eaaea2be63c28b911c16799b79587ed4ff92e11c4de"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CAD>(arg0, 9, 0x1::string::utf8(b"CAD"), 0x1::string::utf8(b"Cat Donald"), 0x1::string::utf8(b"Cat donald is mac donald on Sui"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a4971d121241f63fb7f2b19d0afc51ed8ff6d4624fd378f10048dacb961d8958.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CAD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CAD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

