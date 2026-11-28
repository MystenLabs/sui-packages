module 0x9d6968c1073377feee148995d15677d3452c0aec5600eaca0333be6124f62332::halo {
    struct HALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"78fd9314900411d737ffbba456064e4ead8e244c652eb4ff7634c544ca3a212e")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"78fd9314900411d737ffbba456064e4ead8e244c652eb4ff7634c544ca3a212e"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HALO>(arg0, 9, 0x1::string::utf8(b"HALO"), 0x1::string::utf8(b"HALO"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/cb4c9bf10477061736d4c17c5c17523aabfcfc0372a5a52273f0ef9e28831cf4.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HALO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HALO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

