module 0x8569d35c1e78900d51aa6c32303411d0b00b73cbe398a940c0728eeed51c1f4e::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"8636f3b508dd3636c9642f3d98d299aba803b77bdffe11a0c2768c98732dcfcd")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"8636f3b508dd3636c9642f3d98d299aba803b77bdffe11a0c2768c98732dcfcd"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PENGU>(arg0, 6, 0x1::string::utf8(b"PENGU"), 0x1::string::utf8(b"Pengu"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/1180e190b5b90a9075eec84493ff9404ce0a626d6397fd0b5a5cf1c49a40e2ca.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PENGU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PENGU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

