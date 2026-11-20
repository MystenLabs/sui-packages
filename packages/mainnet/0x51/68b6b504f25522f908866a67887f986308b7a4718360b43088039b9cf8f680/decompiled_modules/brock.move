module 0x5168b6b504f25522f908866a67887f986308b7a4718360b43088039b9cf8f680::brock {
    struct BROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a714206ac3ec2b16f4a476064aabe4c3fa2db2f5c6576a0b5d2b1e8034eafa7f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a714206ac3ec2b16f4a476064aabe4c3fa2db2f5c6576a0b5d2b1e8034eafa7f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BROCK>(arg0, 9, 0x1::string::utf8(b"BROCK"), 0x1::string::utf8(b"blast rock"), 0x1::string::utf8(b"blast rock"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d1b8add1ded0da99c03816521b1b64433b5041f9c4d470d589b23c8a4f50f640.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BROCK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BROCK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

