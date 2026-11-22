module 0xe584833a0713669e519bad3a3c107eeacb1c5541143873b118241e0efa50ea6::npcs {
    struct NPCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPCS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"93a7d4025aeaea4719dce3372cfd148e21c1f4168484408641d63737dc569ab7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"93a7d4025aeaea4719dce3372cfd148e21c1f4168484408641d63737dc569ab7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NPCS>(arg0, 9, 0x1::string::utf8(b"NPCS"), 0x1::string::utf8(b"NPCsui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/de23153ffd22108fcd06f3944c56128a45ad18546650bdf04745ea61e4e1f112.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NPCS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NPCS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

