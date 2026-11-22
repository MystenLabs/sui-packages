module 0x4ccbd5ae5feac46a5427ada7d54d84073e630eaa5e40445145e8a376b00a1a8b::afarming {
    struct AFARMING has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFARMING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f009a44c0d1dbab5407f8a1c5cf29479dc2dbecf5a832ea8f91b02f7951bd5e7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f009a44c0d1dbab5407f8a1c5cf29479dc2dbecf5a832ea8f91b02f7951bd5e7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<AFARMING>(arg0, 9, 0x1::string::utf8(b"AFARMING"), 0x1::string::utf8(b"ahmad farming sui"), 0x1::string::utf8(b"Ahmad is interested in farming."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/65ea334889962938a377129f0787a26a5407f49709081c95c1d90a6cfc60a8c0.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<AFARMING>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<AFARMING>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

