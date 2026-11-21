module 0x691e81c0c5c3946f2d6678884c5191032535e7ffea1b66f6ba5fe72c003a1759::tg {
    struct TG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9bd20ffb503911de7188fbae193c2f63f3ff0a77d7a19becffffe3c7987dcb61")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9bd20ffb503911de7188fbae193c2f63f3ff0a77d7a19becffffe3c7987dcb61"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TG>(arg0, 9, 0x1::string::utf8(b"TG"), 0x1::string::utf8(b"Telegram"), 0x1::string::utf8(x"412066756e20636f6d6d756e697479206d656d6520696e7370697265642062792054656c656772616d2c206272696e67696e672063686174732c20637265617469766974792c20616e6420676f6f6420766962657320746f6765746865722e20f09f9299"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/446992a20a895e75eb1713f0b9801b1ba47c1cb6110ff683ee9908e0fe00d74a.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

