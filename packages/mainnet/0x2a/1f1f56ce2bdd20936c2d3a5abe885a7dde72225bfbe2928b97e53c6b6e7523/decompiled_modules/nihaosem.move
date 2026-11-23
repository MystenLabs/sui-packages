module 0x2a1f1f56ce2bdd20936c2d3a5abe885a7dde72225bfbe2928b97e53c6b6e7523::nihaosem {
    struct NIHAOSEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIHAOSEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"ce65eaf34e269ec7dfdc7d347972ff32a55f90cb1d0e024a9f4f6ad39e8e7808")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"ce65eaf34e269ec7dfdc7d347972ff32a55f90cb1d0e024a9f4f6ad39e8e7808"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NIHAOSEM>(arg0, 9, 0x1::string::utf8(b"NIHAOSEM"), 0x1::string::utf8(b"Ni Hao Ansem"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/e31d9ed627237c1fce75d8e58f69345bd7a6d1e9b503ff07082787c0ce801e44.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NIHAOSEM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NIHAOSEM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

