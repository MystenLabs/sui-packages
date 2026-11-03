module 0x628d4d7454586e5af39ab85137422f2669ba33867c235dfb3a8f19b13a1ede0d::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::creator_authority::new_account(x"000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f")
        } else {
            0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::creator_authority::new_address(0x2::address::from_bytes(x"000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"))
        };
        0x2::transfer::public_transfer<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::launch_ticket::LaunchTicket<MEME>>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::launch_ticket::new<MEME>(arg0, 9, 0x1::string::utf8(b"MEME"), 0x1::string::utf8(b"Blast Meme"), 0x1::string::utf8(b"A Meme launched on Blast"), 0x1::string::utf8(b"https://blast.fun/meme.png"), v0, false, 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

