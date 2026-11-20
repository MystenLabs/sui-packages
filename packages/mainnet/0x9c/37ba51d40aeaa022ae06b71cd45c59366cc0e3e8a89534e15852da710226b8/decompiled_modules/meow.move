module 0x9c37ba51d40aeaa022ae06b71cd45c59366cc0e3e8a89534e15852da710226b8::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"480f4247cd2569a0ee22b28bc5880e8514e4f1f27c290f16e8e4ed8a70a5b63e")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"480f4247cd2569a0ee22b28bc5880e8514e4f1f27c290f16e8e4ed8a70a5b63e"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MEOW>(arg0, 9, 0x1::string::utf8(b"MEOW"), 0x1::string::utf8(b"MEOW"), 0x1::string::utf8(b"this is just a meme on sui network"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/0cd7de3d3567985dd1351cb51f59bd948193a9f3cd944be9c417ea2d6eb3bbcd.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MEOW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MEOW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

