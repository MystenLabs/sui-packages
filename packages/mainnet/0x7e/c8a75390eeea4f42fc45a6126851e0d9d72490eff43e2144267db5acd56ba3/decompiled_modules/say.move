module 0x7ec8a75390eeea4f42fc45a6126851e0d9d72490eff43e2144267db5acd56ba3::say {
    struct SAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"d3cacc3cf9872ec5c48e7c80cc4ea83195f5dae1bb0439f56f117555e62d33df")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"d3cacc3cf9872ec5c48e7c80cc4ea83195f5dae1bb0439f56f117555e62d33df"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SAY>(arg0, 9, 0x1::string::utf8(b"SAY"), 0x1::string::utf8(b"SAYSO"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f8a55ce49edcec980877118fb8ab7525e8c7b79c3160e2ba6b8f31d02542ed4c.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SAY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SAY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

