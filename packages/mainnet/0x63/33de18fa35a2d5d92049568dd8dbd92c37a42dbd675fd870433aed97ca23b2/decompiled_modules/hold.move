module 0x6333de18fa35a2d5d92049568dd8dbd92c37a42dbd675fd870433aed97ca23b2::hold {
    struct HOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"043f8d104f211786dc506418e9ba9420a4d81b0b5a69cab6024a709b047a7904")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"043f8d104f211786dc506418e9ba9420a4d81b0b5a69cab6024a709b047a7904"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HOLD>(arg0, 9, 0x1::string::utf8(b"HOLD"), 0x1::string::utf8(b"HOLD"), 0x1::string::utf8(b"HOLD just for fun."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/8414c8d719cd76973e5c9c5986ac7d58a29a1dff0adc94dbc9e23b999e56f024.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HOLD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HOLD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

