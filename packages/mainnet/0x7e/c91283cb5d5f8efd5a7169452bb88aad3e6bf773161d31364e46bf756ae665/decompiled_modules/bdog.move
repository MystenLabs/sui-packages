module 0x7ec91283cb5d5f8efd5a7169452bb88aad3e6bf773161d31364e46bf756ae665::bdog {
    struct BDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"1c1b6ba0b01ba4c5706728e62c500bd76087c2de5dab9dabe0cd65c9a5e574fa")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"1c1b6ba0b01ba4c5706728e62c500bd76087c2de5dab9dabe0cd65c9a5e574fa"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BDOG>(arg0, 9, 0x1::string::utf8(b"BDOG"), 0x1::string::utf8(b"b1ackd0g"), 0x1::string::utf8(x"4e6f20726f61646d61702e204e6f2070726573616c652e0a0a0a5468697320697320746865207265616c207472656e636865732e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/3c4642b7719d590eb54f7bcb831d7312455f79dd20be28689b2197fccaac3f8f.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BDOG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

