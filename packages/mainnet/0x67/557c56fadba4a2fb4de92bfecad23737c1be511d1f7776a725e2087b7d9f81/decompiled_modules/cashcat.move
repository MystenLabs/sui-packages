module 0x67557c56fadba4a2fb4de92bfecad23737c1be511d1f7776a725e2087b7d9f81::cashcat {
    struct CASHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e612ffa41149106d593942d450a1e297878d666613c29de95fd0994cd4cae0d0")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e612ffa41149106d593942d450a1e297878d666613c29de95fd0994cd4cae0d0"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CASHCAT>(arg0, 9, 0x1::string::utf8(b"CASHCAT"), 0x1::string::utf8(b"Cashcat"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/802c0a8d93f75a57619b4d117a28024a5d3485466cd95cc9eb3148852669f687.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CASHCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CASHCAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

