module 0x8b5e54a2e35caf27594ccac6d5ea763d0f12395c34f2a5462065a4f8852c5ef::nihaosem {
    struct NIHAOSEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIHAOSEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e8303008a48a6aef11e6fb9d8c6c168e8806eacd3d60c2177a6f3c41df16daa4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e8303008a48a6aef11e6fb9d8c6c168e8806eacd3d60c2177a6f3c41df16daa4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NIHAOSEM>(arg0, 9, 0x1::string::utf8(b"NIHAOSEM"), 0x1::string::utf8(b"Ni Hao Ansem"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/192f4545d6298f6bde25da34bc119ca71033d7a20c51eb19f5c54b3d0820c8be.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NIHAOSEM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NIHAOSEM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

