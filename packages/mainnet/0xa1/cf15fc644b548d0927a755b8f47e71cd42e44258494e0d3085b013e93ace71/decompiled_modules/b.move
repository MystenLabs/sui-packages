module 0xa1cf15fc644b548d0927a755b8f47e71cd42e44258494e0d3085b013e93ace71::b {
    struct B has drop {
        dummy_field: bool,
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"2dd8b2dcf810087cc99dc5e6f262fa165339ea8d2bf234ab33d78d81ff1b3fb6")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"2dd8b2dcf810087cc99dc5e6f262fa165339ea8d2bf234ab33d78d81ff1b3fb6"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<B>(arg0, 9, 0x1::string::utf8(b"B"), 0x1::string::utf8(b"Press B"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/cc599c13e42fa95449115a03b0859c9b62ea82e1e2f0cd245e1a242359846309.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<B>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<B>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

