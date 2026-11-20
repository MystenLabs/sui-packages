module 0xa6d441bad188e4d952d30bba72f17fda099fabf4da4cfd18c5566a30bd9651c9::niyi {
    struct NIYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"33ce4b8c946454ac96afa3a2e11d088c7203e421b10c76cafd86e54436f9fb51")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"33ce4b8c946454ac96afa3a2e11d088c7203e421b10c76cafd86e54436f9fb51"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NIYI>(arg0, 9, 0x1::string::utf8(b"NIYI"), 0x1::string::utf8(b"Adenigga"), 0x1::string::utf8(b"Wal stakers will be the happiest on earth,"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/134f6ea66b66ca5ab4c5d1683e3c970e3d16936d8ac46c7180a5fb0aacf37140.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NIYI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NIYI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

