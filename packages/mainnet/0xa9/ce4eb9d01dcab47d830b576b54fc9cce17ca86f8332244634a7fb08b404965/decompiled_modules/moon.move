module 0xa9ce4eb9d01dcab47d830b576b54fc9cce17ca86f8332244634a7fb08b404965::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9e06771f725faafa7c53e7e6edb2b794e44a67050716916822dae8e5ebdebf95")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9e06771f725faafa7c53e7e6edb2b794e44a67050716916822dae8e5ebdebf95"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MOON>(arg0, 9, 0x1::string::utf8(b"MOON"), 0x1::string::utf8(b"TO THE MOON"), 0x1::string::utf8(b"We goin there!"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b4cfc4ce5d3bdfbd9de5cd44f1a677b43fd46280b87a8c38dac2fa3a6d7919fc.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MOON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MOON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

