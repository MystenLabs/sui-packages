module 0x257d199e89f8fe94c718f0917f11fb96de47d0d856cb37ce0cdac7c0e3d6cce8::ye {
    struct YE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"8636f3b508dd3636c9642f3d98d299aba803b77bdffe11a0c2768c98732dcfcd")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"8636f3b508dd3636c9642f3d98d299aba803b77bdffe11a0c2768c98732dcfcd"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<YE>(arg0, 9, 0x1::string::utf8(b"YE"), 0x1::string::utf8(b"YE"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/85d2f54e1fd36f4dc55691a99468f5cf1f96c82f57e5b01941efc62743c98689.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<YE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<YE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

