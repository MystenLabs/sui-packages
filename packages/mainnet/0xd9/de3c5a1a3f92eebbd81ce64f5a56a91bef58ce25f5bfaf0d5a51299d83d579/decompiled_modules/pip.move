module 0xd9de3c5a1a3f92eebbd81ce64f5a56a91bef58ce25f5bfaf0d5a51299d83d579::pip {
    struct PIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"2e66a9db4b46b70e36ac2b4d04c13ff0038fc6b70431e5c8d36a89010b888d4a")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"2e66a9db4b46b70e36ac2b4d04c13ff0038fc6b70431e5c8d36a89010b888d4a"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PIP>(arg0, 9, 0x1::string::utf8(b"PIP"), 0x1::string::utf8(b"PiP & Friends"), 0x1::string::utf8(b"in a world where small things often go unnoticed, PiP reminds us that even the tiniest droplet can create waves of change. A community that values creativity, resilience, and the power of connection."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/dc595aa2d9f82ae1897674be38a8a75fe04deaf07dadd3cc975b79faab891faf.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PIP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PIP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

