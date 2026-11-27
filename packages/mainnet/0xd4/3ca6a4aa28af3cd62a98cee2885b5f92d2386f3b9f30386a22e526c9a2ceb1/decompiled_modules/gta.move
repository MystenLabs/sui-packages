module 0xd43ca6a4aa28af3cd62a98cee2885b5f92d2386f3b9f30386a22e526c9a2ceb1::gta {
    struct GTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"78fd9314900411d737ffbba456064e4ead8e244c652eb4ff7634c544ca3a212e")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"78fd9314900411d737ffbba456064e4ead8e244c652eb4ff7634c544ca3a212e"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTA>(arg0, 9, 0x1::string::utf8(b"GTA"), 0x1::string::utf8(b"Grand Theft Auto"), 0x1::string::utf8(b"This is GTA"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b8771482434028436e18b1ae69151c23f83791ee4e1023e94a634d97fb531785.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

