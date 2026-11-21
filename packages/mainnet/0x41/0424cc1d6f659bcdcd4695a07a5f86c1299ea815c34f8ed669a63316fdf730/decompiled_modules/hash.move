module 0x410424cc1d6f659bcdcd4695a07a5f86c1299ea815c34f8ed669a63316fdf730::hash {
    struct HASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4e3770345df31d6242529195f1b3e28d008470db5c788cce353eb99b543faaca")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4e3770345df31d6242529195f1b3e28d008470db5c788cce353eb99b543faaca"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HASH>(arg0, 9, 0x1::string::utf8(b"HASH"), 0x1::string::utf8(b"Hashlings"), 0x1::string::utf8(x"486173686c696e677320c2b720506978656c20426974636f696e206d696e65727320c2b72046616e73207370696e2c204c45447320626c696e6b2c20636f696e7320706f700a737569"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/4b355b5cc597eb1dd893b2f9d84245337a08c883bf8961971f772e4594e4e28d.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HASH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HASH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

