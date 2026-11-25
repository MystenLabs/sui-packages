module 0xa12d411734f20dfbc7e7166fccf21d955ba12bd6bbb952b7b395ca679fdcdf9d::tsalb {
    struct TSALB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSALB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"bcc585abd5934a252ea1b6af12b5ce96c64e2a7a23b0109346311a6b32e4e5d5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"bcc585abd5934a252ea1b6af12b5ce96c64e2a7a23b0109346311a6b32e4e5d5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TSALB>(arg0, 9, 0x1::string::utf8(b"TSALB"), 0x1::string::utf8(b"TSALB"), 0x1::string::utf8(b".hcnual rof raelC"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/3122938d46c9449a9e212a059eb228979a85fdfc5b83f4e5e825ff9c3d561a85.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TSALB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TSALB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

