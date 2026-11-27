module 0xd0727b902ae69f460a68d4cb455b53d2a31a4eab79abc515f52e96cd184656e7::blarmy {
    struct BLARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"2126521003d7b2fc7825dde3d373fb634caa5615ed180c59c09339ceeed91769")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"2126521003d7b2fc7825dde3d373fb634caa5615ed180c59c09339ceeed91769"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLARMY>(arg0, 9, 0x1::string::utf8(b"BLARMY"), 0x1::string::utf8(b"Blast Army"), 0x1::string::utf8(x"7765e280996c6c20626520676976696e67206177617920612066726565204e465420746f2074686f73652077686f20686f6c6420746865206d656d6520746f6b656e207769746820612076616c7565206f662061726f756e64203330205355492e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/1a8360dba4aca8419f9861332d46605e1f93c952e880467a55878e9ad3b79f97.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLARMY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLARMY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

