module 0xd6b49cb3ae38371fbae20c51882198885ccf5c3ca3be6f8f7058709b26c45a9::hmmm {
    struct HMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"ce65eaf34e269ec7dfdc7d347972ff32a55f90cb1d0e024a9f4f6ad39e8e7808")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"ce65eaf34e269ec7dfdc7d347972ff32a55f90cb1d0e024a9f4f6ad39e8e7808"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HMMM>(arg0, 9, 0x1::string::utf8(b"HMMM"), 0x1::string::utf8(b"HMMM"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f67e735d1ef0bcadcab1f0638d0b59f474092723f9307d44252605bf1693485d.webp"), v0, true, 2000, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HMMM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HMMM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

