module 0x55dbc935e11d2f53f0d7a9ebbeb2b0ccfa2c3f0cb1c1e58697ba444c4cf1c1ed::f0f {
    struct F0F has drop {
        dummy_field: bool,
    }

    fun init(arg0: F0F, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"7bf7fbb19ef175a77751d74618318983a78aeb32763efa58d9a2db60016e191b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"7bf7fbb19ef175a77751d74618318983a78aeb32763efa58d9a2db60016e191b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<F0F>(arg0, 9, 0x1::string::utf8(b"F0F"), 0x1::string::utf8(b"404"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/132c3e26457666d00c7620dade8929060ad44238e0de93fa9834e5626f3b3aa8.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<F0F>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<F0F>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

