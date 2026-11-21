module 0xf1cf943aad9c9a7c7299051b304ad4f5faa081088319558cea3215594f2d0a06::smack {
    struct SMACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"c822e2e2d8ea055bb61ab96cc44dcd867ff8f8e8bfc4b2325aca3d55968c203e")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"c822e2e2d8ea055bb61ab96cc44dcd867ff8f8e8bfc4b2325aca3d55968c203e"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SMACK>(arg0, 9, 0x1::string::utf8(b"SMACK"), 0x1::string::utf8(b"Smack Cat"), 0x1::string::utf8(b"The paw of justice on Sui. Bad behavior gets the paw."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d96292004e413cc63a201207e81232e212f81b6293b42c9119484464e22f126d.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SMACK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SMACK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

