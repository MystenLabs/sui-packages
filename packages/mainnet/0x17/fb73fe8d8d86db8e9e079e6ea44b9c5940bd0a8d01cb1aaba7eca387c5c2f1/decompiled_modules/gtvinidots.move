module 0x17fb73fe8d8d86db8e9e079e6ea44b9c5940bd0a8d01cb1aaba7eca387c5c2f1::gtvinidots {
    struct GTVINIDOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVINIDOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVINIDOTS>(arg0, 9, 0x1::string::utf8(b"GTVINIDOTS"), 0x1::string::utf8(b"vini"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/DPBZUsgWKrPb8tUxVMgBGcZDHYjHOqHNKQ64aAFChomV_1OQBDULMtqOj0q6UK5yRBfN_vjSKo3mgAm8k4PFAzdhgYiwljJXstGUnjd-EwIKSkdPj5rEOTivF3daHLZmqMZd6xjNHtE1VX3p69C-3wu1IdQs-0ND4PisouRvwjFsXo6zMj7bP93_WNIiuODIqSRXp1B2qkj8Gh0GmGNNDzkJG7zsuWFoOUOLVTecTiGgAS5QCt0koZLR82rh99DaDSgjslcwiTYs4Hl9fzeNM0TBiT9QStRgvPjeTcfZtkcJ8KbV7kMg48BeQOvKPhmOYZdk3DGFBXDuS808U7C7dg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVINIDOTS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVINIDOTS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

