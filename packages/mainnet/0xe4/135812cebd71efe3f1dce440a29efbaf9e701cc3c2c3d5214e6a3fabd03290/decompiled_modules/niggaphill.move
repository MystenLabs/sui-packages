module 0xe4135812cebd71efe3f1dce440a29efbaf9e701cc3c2c3d5214e6a3fabd03290::niggaphill {
    struct NIGGAPHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGAPHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4e3770345df31d6242529195f1b3e28d008470db5c788cce353eb99b543faaca")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4e3770345df31d6242529195f1b3e28d008470db5c788cce353eb99b543faaca"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NIGGAPHILL>(arg0, 9, 0x1::string::utf8(b"NIGGAPHILL"), 0x1::string::utf8(b"Nigga Jean Phil"), 0x1::string::utf8(x"546865726520617265206e6f2073686f7274637574732061726f756e64207175616c6974792e0a0a4f7569204d6164616d652e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/5b4030894ca2e863be4806d819e936d155f3e56b223a00196a5ec04b803244fe.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NIGGAPHILL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NIGGAPHILL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

