module 0xe2f9617b7a07d54cd5ef9e744b6fa0d539de2ff0fc2b7768503d049edbb4b7b9::caw {
    struct CAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3a5534d197a2c5495c8ba163cbb42f3601bc1fe187c80a41dcb906b9af7322a9")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3a5534d197a2c5495c8ba163cbb42f3601bc1fe187c80a41dcb906b9af7322a9"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CAW>(arg0, 9, 0x1::string::utf8(b"CAW"), 0x1::string::utf8(b"Caw Caw"), 0x1::string::utf8(b"$CAW is the crow who watched the chart, blinked twice, and said \"caw.\" Feathers everywhere, eyes the size of dinner plates, and a beak that has been frowning since the last cycle. He's not here to hype anything. He's here because he never left. Perch next to him and stay a while."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b35cc4defbddf073a7250758e201c493967709e8239849698e663fbb3d254aba.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CAW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CAW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

