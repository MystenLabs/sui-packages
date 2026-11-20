module 0x53c35a28355e886b1e6a09ec0944cf6dbbd8f5ed7ce0029009b08eb2cd763201::btn {
    struct BTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"ed495df2b89d858963a8d814b221e69887cc2d09a394b51737202df727ff865e")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"ed495df2b89d858963a8d814b221e69887cc2d09a394b51737202df727ff865e"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BTN>(arg0, 9, 0x1::string::utf8(b"BTN"), 0x1::string::utf8(b"bike tayson"), 0x1::string::utf8(b"bike tayson NNNNNNNNNNNNNN"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/96022bc2c394cc66aab192f9578146e50e7e5925a4941f6ace3b4cfc21bcee49.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BTN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BTN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

