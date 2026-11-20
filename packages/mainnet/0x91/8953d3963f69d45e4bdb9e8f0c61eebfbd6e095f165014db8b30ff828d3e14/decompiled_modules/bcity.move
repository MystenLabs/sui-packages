module 0x918953d3963f69d45e4bdb9e8f0c61eebfbd6e095f165014db8b30ff828d3e14::bcity {
    struct BCITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"07ff98b5f212d40071a0d7c7a67381a9b6d9bd856c59baea78f1df8e63d961be")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"07ff98b5f212d40071a0d7c7a67381a9b6d9bd856c59baea78f1df8e63d961be"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BCITY>(arg0, 9, 0x1::string::utf8(b"BCITY"), 0x1::string::utf8(b"Blast City"), 0x1::string::utf8(b"Blast city is bringing Gamefi to the Blast Ecosystem. Think it Play it."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/80a8471c61c2eb4498c35b187bb994ed63a14a29db9c9f2567a35e13d827e884.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BCITY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BCITY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

