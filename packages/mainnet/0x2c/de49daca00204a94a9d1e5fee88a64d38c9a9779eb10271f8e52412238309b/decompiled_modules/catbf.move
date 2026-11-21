module 0x2cde49daca00204a94a9d1e5fee88a64d38c9a9779eb10271f8e52412238309b::catbf {
    struct CATBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f009a44c0d1dbab5407f8a1c5cf29479dc2dbecf5a832ea8f91b02f7951bd5e7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f009a44c0d1dbab5407f8a1c5cf29479dc2dbecf5a832ea8f91b02f7951bd5e7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CATBF>(arg0, 9, 0x1::string::utf8(b"CATBF"), 0x1::string::utf8(b"cat blast fun"), 0x1::string::utf8(b"A cat with salt"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/17826ab948597f4c3b1890b477d6680f86bc82ab5bfc4d77745afaaa8bc5dd20.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CATBF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CATBF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

