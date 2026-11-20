module 0x846619d2ea974d74ca50e069bb227cf3446e95be9929a429f712361868809000::thanksbowling {
    struct THANKSBOWLING has drop {
        dummy_field: bool,
    }

    fun init(arg0: THANKSBOWLING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4e3770345df31d6242529195f1b3e28d008470db5c788cce353eb99b543faaca")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4e3770345df31d6242529195f1b3e28d008470db5c788cce353eb99b543faaca"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<THANKSBOWLING>(arg0, 9, 0x1::string::utf8(b"THANKSBOWLING"), 0x1::string::utf8(b"thanksbowling"), 0x1::string::utf8(b"a game where you bowl a frozen turkey at cranberry sauce. free in your browser, up to 8 friends on one lane. earn thanks points up to thanksgiving night."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/0b3052650ef351e5477f0a092f1a1b3343db2a237dfe422e12a8361b9d539871.webp"), v0, true, 100, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<THANKSBOWLING>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<THANKSBOWLING>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

