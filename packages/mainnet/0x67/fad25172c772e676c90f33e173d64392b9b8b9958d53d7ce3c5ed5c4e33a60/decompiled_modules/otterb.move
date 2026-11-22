module 0x67fad25172c772e676c90f33e173d64392b9b8b9958d53d7ce3c5ed5c4e33a60::otterb {
    struct OTTERB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTERB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f009a44c0d1dbab5407f8a1c5cf29479dc2dbecf5a832ea8f91b02f7951bd5e7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f009a44c0d1dbab5407f8a1c5cf29479dc2dbecf5a832ea8f91b02f7951bd5e7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<OTTERB>(arg0, 9, 0x1::string::utf8(b"OTTERB"), 0x1::string::utf8(b"Otter blast fun"), 0x1::string::utf8(b"The clever blue otter"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/074a85de644ddd3174c4c0330597d2fc68ce1a5bcb1a33c004e8df5675d18447.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<OTTERB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<OTTERB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

