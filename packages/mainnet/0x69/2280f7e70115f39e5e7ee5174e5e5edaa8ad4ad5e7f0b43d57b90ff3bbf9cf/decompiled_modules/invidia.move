module 0x692280f7e70115f39e5e7ee5174e5e5edaa8ad4ad5e7f0b43d57b90ff3bbf9cf::invidia {
    struct INVIDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: INVIDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3ef25b52a6c23bb8114e6fd70ef332f678b115415f7bd802447a19e8aec24ed7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3ef25b52a6c23bb8114e6fd70ef332f678b115415f7bd802447a19e8aec24ed7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<INVIDIA>(arg0, 9, 0x1::string::utf8(b"INVIDIA"), 0x1::string::utf8(b"Invidia"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/8f993db0b7bdf0250156a2fc5a2e82812ffa944ea93d9980f1ccba2d406e3bb8.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<INVIDIA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<INVIDIA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

