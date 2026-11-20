module 0xddc3ba4738230e836ac2761083aeae9b92ba2b1d5659bc4e156eba096f3b540e::plbo {
    struct PLBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLBO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"23c3a54c0271582342bb7817cefa7e0d170f47d01329aad46213f4ed6f7dad11")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"23c3a54c0271582342bb7817cefa7e0d170f47d01329aad46213f4ed6f7dad11"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PLBO>(arg0, 9, 0x1::string::utf8(b"PLBO"), 0x1::string::utf8(b"PlayBlastOff"), 0x1::string::utf8(b"Pink rocket. No brakes."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/4adab0849d31cb8ca93700c86422973fa20d207f03fb17dec3810b8ca07883c2.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PLBO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PLBO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

