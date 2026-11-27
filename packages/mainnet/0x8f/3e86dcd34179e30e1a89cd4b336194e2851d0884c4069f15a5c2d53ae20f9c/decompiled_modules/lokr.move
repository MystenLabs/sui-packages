module 0x8f3e86dcd34179e30e1a89cd4b336194e2851d0884c4069f15a5c2d53ae20f9c::lokr {
    struct LOKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"fcf3ab4396ac3392a974a4a707f43f8b4dddba98fb4ef6dc9f76dddc24f5d140")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"fcf3ab4396ac3392a974a4a707f43f8b4dddba98fb4ef6dc9f76dddc24f5d140"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LOKR>(arg0, 9, 0x1::string::utf8(b"LOKR"), 0x1::string::utf8(b"LOKR"), 0x1::string::utf8(b"Your private workspace for the onchain world. Inspect the chain. Control what you reveal."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b7d2030d7a5bffa428d744e44ca6637397d17a6ea95be11484d7e4efcd6b005c.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LOKR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LOKR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

