module 0x53eef8dd1eb9c126f63b74197d8ea4185fa33d7d920ad7793cac4735013795d5::bcap {
    struct BCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e0d6f278cf63f1acf11791f33e823dee5ac76cb2cff7ec58b0e4ce6db4ae7aa1")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e0d6f278cf63f1acf11791f33e823dee5ac76cb2cff7ec58b0e4ce6db4ae7aa1"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BCAP>(arg0, 9, 0x1::string::utf8(b"BCAP"), 0x1::string::utf8(b"Blast Cap"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a579f937799073bac00c70df56ef61a0cbfcf5581c2813a6b64bba5bf7d2b8cc.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BCAP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BCAP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

