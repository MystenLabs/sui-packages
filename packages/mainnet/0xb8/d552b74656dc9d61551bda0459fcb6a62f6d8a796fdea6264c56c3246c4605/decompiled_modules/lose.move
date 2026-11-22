module 0xb8d552b74656dc9d61551bda0459fcb6a62f6d8a796fdea6264c56c3246c4605::lose {
    struct LOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e2b31c32f833f673415bebb922ead483594622097b9df7ec9979e9f7455787e0")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e2b31c32f833f673415bebb922ead483594622097b9df7ec9979e9f7455787e0"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LOSE>(arg0, 6, 0x1::string::utf8(b"LOSE"), 0x1::string::utf8(b"losecon"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/21e06dae37bf91d989097c0783c7b9a96e22b59a6174f7db5d421e09667caf95.webp"), v0, false, 5000, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LOSE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LOSE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

