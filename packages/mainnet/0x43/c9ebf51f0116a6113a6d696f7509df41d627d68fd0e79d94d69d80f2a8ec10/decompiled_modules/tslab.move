module 0x43c9ebf51f0116a6113a6d696f7509df41d627d68fd0e79d94d69d80f2a8ec10::tslab {
    struct TSLAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSLAB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"bcc585abd5934a252ea1b6af12b5ce96c64e2a7a23b0109346311a6b32e4e5d5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"bcc585abd5934a252ea1b6af12b5ce96c64e2a7a23b0109346311a6b32e4e5d5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TSLAB>(arg0, 9, 0x1::string::utf8(b"TSLAB"), 0x1::string::utf8(b"TSLAB"), 0x1::string::utf8(b".hcnual rof raelC"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/3122938d46c9449a9e212a059eb228979a85fdfc5b83f4e5e825ff9c3d561a85.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TSLAB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TSLAB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

