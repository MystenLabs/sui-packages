module 0x6d8067bf5e80e738ee9730925697fd0ef15f24655a5f29303648855ebb779291::bbln {
    struct BBLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"73da8646bb52fac8d0f2680e132245330761fc1e0dffa5c0f644cb1c120a7887")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"73da8646bb52fac8d0f2680e132245330761fc1e0dffa5c0f644cb1c120a7887"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BBLN>(arg0, 9, 0x1::string::utf8(b"BBLN"), 0x1::string::utf8(b"Babalon"), 0x1::string::utf8(b"Belongs to a Goddess"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/0088aa2de9d26cee3bd88e736dd68e095dd3c74abdde2aca520a07bc9c045d22.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BBLN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BBLN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

