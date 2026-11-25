module 0x1765b63bfe511beafee6d0e8912ac3a635adf63f7e472e0256ea72c5ed7c203f::gtlinksm {
    struct GTLINKSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLINKSM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLINKSM>(arg0, 9, 0x1::string::utf8(b"GTLINKSM"), 0x1::string::utf8(b"Maks"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/vJIuqS5rful5CDc351ln9TXLZi1oG6ovDUFqfGg3yNNhruWKP5GNfraUPOFzfiala7vw2LpgfFeeTAlwzt4tmnNcweWCJnmu41iUWHUnKEu099wZ3-awCnwQEG6OrexoWmiQLaBNjZR8T81nkpYKYlSPwZQ8N0tIG23O3mE5RmjKgDOGftEsVIyq_G7Ia8-mvqLztf8nphnY17Kc5UCy4YPGzh0Gi5CuUnw3tJ6B4txVysnKu_qTb9-TLrDdrZAIyE6MIx6mC8iOjebfbITy-wdFd3tKKQ8PmRc27D5jwAYKa2o7aEOh_lFdsUP4wDfAQwo9QoqzZqxwI0ytjeAmBg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLINKSM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLINKSM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

