module 0xf26e5f4bc4f095b7f69e54655724c9a74e75e058f5cb422aa5193d851fdb9a45::hamsters {
    struct HAMSTERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTERS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f009a44c0d1dbab5407f8a1c5cf29479dc2dbecf5a832ea8f91b02f7951bd5e7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f009a44c0d1dbab5407f8a1c5cf29479dc2dbecf5a832ea8f91b02f7951bd5e7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HAMSTERS>(arg0, 9, 0x1::string::utf8(b"HAMSTERS"), 0x1::string::utf8(b"Hamster sui"), 0x1::string::utf8(b"A tiny little cutie"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/08736626766fefe42defcdd2a9172719239bf59302555b5e85b5ccd34287c39c.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HAMSTERS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HAMSTERS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

