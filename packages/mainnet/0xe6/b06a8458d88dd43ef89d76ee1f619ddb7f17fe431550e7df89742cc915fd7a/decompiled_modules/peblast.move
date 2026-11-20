module 0xe6b06a8458d88dd43ef89d76ee1f619ddb7f17fe431550e7df89742cc915fd7a::peblast {
    struct PEBLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEBLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"101e9319ef4f4d8a6897046dc038090f27bd842e49b414b01f3d05151305efb1")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"101e9319ef4f4d8a6897046dc038090f27bd842e49b414b01f3d05151305efb1"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PEBLAST>(arg0, 9, 0x1::string::utf8(b"PEBLAST"), 0x1::string::utf8(b"pepeblast"), 0x1::string::utf8(b"pepeblast"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/2d49a46a70153d2ca4367604f9a0bc20d10a23e788c7da84ee63dbb61bff786e.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PEBLAST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PEBLAST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

