module 0x9838de76997a223f3dda98d5394226fc59a8f6214574ba71f1c639c840d0369::suifrog {
    struct SUIFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"987922f8c797757e0a6c596c298ba5bb23c1c34c21411f9302107bde1cc36dc4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"987922f8c797757e0a6c596c298ba5bb23c1c34c21411f9302107bde1cc36dc4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SUIFROG>(arg0, 9, 0x1::string::utf8(b"SUIFROG"), 0x1::string::utf8(b"SuiFrog"), 0x1::string::utf8(b"Kostas The Frog"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/3713ced71ae4ec380e5b6f334169adcccc28865876e41d210a86c5c2dc6b5d84.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SUIFROG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SUIFROG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

