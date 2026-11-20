module 0x5131d41fae1a5b58e402156c7fbd3451ad943cccdf5222dd18d2327ba54702c5::runt {
    struct RUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4e3770345df31d6242529195f1b3e28d008470db5c788cce353eb99b543faaca")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4e3770345df31d6242529195f1b3e28d008470db5c788cce353eb99b543faaca"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<RUNT>(arg0, 9, 0x1::string::utf8(b"RUNT"), 0x1::string::utf8(b"runtfun"), 0x1::string::utf8(x"6576657279206c61756e63687061642061736b7320666f72206120746f6b656e20666972737420616e6420612063726f7764206c617465722e0a0a776520666c69707065642069742e206e616d652074686520636f696e2c20736861726520746865206c696e6b2c20616e6420696620796f75722070656f706c652073686f772075702c2074686174277320746865206f6e652074686174206c61756e636865732e0a0a6e6f20746f6b656e20746f206465706c6f792c206e6f2077616c6c65742c206e6f20636f73742e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/28cc79f26b5cac4b7e04cefa106fdf2a766bae84eb33d697dd57cabf557bf75f.webp"), v0, true, 100, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<RUNT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<RUNT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

