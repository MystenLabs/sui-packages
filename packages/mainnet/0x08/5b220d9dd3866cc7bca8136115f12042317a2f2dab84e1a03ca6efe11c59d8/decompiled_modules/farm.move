module 0x85b220d9dd3866cc7bca8136115f12042317a2f2dab84e1a03ca6efe11c59d8::farm {
    struct FARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"eed6ff3c51264abe4fa7e4eddefe30fba7e49a6e4869b233d101dd413e0816b5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"eed6ff3c51264abe4fa7e4eddefe30fba7e49a6e4869b233d101dd413e0816b5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FARM>(arg0, 9, 0x1::string::utf8(b"FARM"), 0x1::string::utf8(b"Farmed"), 0x1::string::utf8(b"sbsbdjdjfbfbdbf"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/3924bfc03ca7f327bd82b76a93fa1cd7ee0f2541a63d85402dc89596af90fd34.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FARM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FARM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

