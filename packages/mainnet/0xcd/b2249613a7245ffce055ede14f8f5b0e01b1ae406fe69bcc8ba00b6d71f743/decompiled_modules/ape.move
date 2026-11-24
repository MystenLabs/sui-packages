module 0xcdb2249613a7245ffce055ede14f8f5b0e01b1ae406fe69bcc8ba00b6d71f743::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"8636f3b508dd3636c9642f3d98d299aba803b77bdffe11a0c2768c98732dcfcd")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"8636f3b508dd3636c9642f3d98d299aba803b77bdffe11a0c2768c98732dcfcd"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<APE>(arg0, 6, 0x1::string::utf8(b"APE"), 0x1::string::utf8(b"Ape"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b07e0d6a0323cc3b4357c34fc4d84c7bc1195c225040f80366cf46bc57d9545b.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<APE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<APE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

