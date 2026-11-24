module 0xb9807b7e6abd01e7ef6a2ec558248c7daf7dcd980b7ddce4d01c903f38753093::money {
    struct MONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3ef25b52a6c23bb8114e6fd70ef332f678b115415f7bd802447a19e8aec24ed7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3ef25b52a6c23bb8114e6fd70ef332f678b115415f7bd802447a19e8aec24ed7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MONEY>(arg0, 9, 0x1::string::utf8(b"MONEY"), 0x1::string::utf8(b"Money"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/55bf550574928290c17f55cca95618f1a6b23008b16f1a2f13887db805e26e4b.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MONEY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MONEY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

