module 0x70e5b202b0810f06bc9ca8710c10beefc9c818e6817d8f0fdbde682bbe603f36::dep {
    struct DEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3dd0afb80443a9b0be4242545c7d5657c5a6abc899036574667470b361c2ecdc")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3dd0afb80443a9b0be4242545c7d5657c5a6abc899036574667470b361c2ecdc"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<DEP>(arg0, 9, 0x1::string::utf8(b"DEP"), 0x1::string::utf8(b"deepz"), 0x1::string::utf8(b"deepz"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/2a446e89dc6670a7e13ca62f08df75358073a991fa4a5686ca5132f0b20fe1f6.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<DEP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DEP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

