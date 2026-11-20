module 0x22c896f6ef9f80651a41391790e4f8bbcefbd24d5a7ea6467393a11478bf9344::seed {
    struct SEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a714206ac3ec2b16f4a476064aabe4c3fa2db2f5c6576a0b5d2b1e8034eafa7f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a714206ac3ec2b16f4a476064aabe4c3fa2db2f5c6576a0b5d2b1e8034eafa7f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SEED>(arg0, 9, 0x1::string::utf8(b"SEED"), 0x1::string::utf8(b"Seed born"), 0x1::string::utf8(b"Seed born fun"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/de4a6ae5762071ef737bbecd6f1556983cbbd8bf31f4a40d2b143d3c4d8eeaa8.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SEED>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SEED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

