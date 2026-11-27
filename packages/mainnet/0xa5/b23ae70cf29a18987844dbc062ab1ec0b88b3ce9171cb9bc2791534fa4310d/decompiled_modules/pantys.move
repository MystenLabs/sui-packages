module 0xa5b23ae70cf29a18987844dbc062ab1ec0b88b3ce9171cb9bc2791534fa4310d::pantys {
    struct PANTYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANTYS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9e06771f725faafa7c53e7e6edb2b794e44a67050716916822dae8e5ebdebf95")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9e06771f725faafa7c53e7e6edb2b794e44a67050716916822dae8e5ebdebf95"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PANTYS>(arg0, 9, 0x1::string::utf8(b"PANTYS"), 0x1::string::utf8(b"Blastys Pantys"), 0x1::string::utf8(b"Blast em"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/309299b33b0d0c014f4b39eba59b08c21f91d1d1acd6d3c1f3892780a572732c.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PANTYS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PANTYS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

