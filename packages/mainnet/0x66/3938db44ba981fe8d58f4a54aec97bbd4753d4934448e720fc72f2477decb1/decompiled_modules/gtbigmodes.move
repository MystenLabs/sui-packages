module 0x663938db44ba981fe8d58f4a54aec97bbd4753d4934448e720fc72f2477decb1::gtbigmodes {
    struct GTBIGMODES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBIGMODES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBIGMODES>(arg0, 9, 0x1::string::utf8(b"GTBIGMODES"), 0x1::string::utf8(b"modesty"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Y4YZeI7zPam4_egx5JxR9JSQF5Nn5c7i_9GRMnjVa_AvAb2btJeCErKqiwmFgMA9r-my_pATUYq3D4iJDmFw8AMqqnrjVkRKLCESIzlfYPpE1SFE-AtyKuZiVw-USbl02oQ5EKdNnAY0aPdRKOAsSQYUOcvjUPMXOvYLEKmK4YFQqaoYrZzjAy1bVk2VDKcsKIjWybXSwv6M1VVfo-fR96sCeuEmRAt2o_qeNiQSEEYHIMUJ1jR2B4iiIgGGMh957K7NNyJdqH8ISXWFTLn-jsaHHayivknkzgck7s5RsDkX96j4jrryE43vSKJHjUOfrgJ0BUnaCiIq0_LmIDcNKA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBIGMODES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBIGMODES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

