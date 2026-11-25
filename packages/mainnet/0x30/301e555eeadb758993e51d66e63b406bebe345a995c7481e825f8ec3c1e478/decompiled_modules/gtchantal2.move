module 0x30301e555eeadb758993e51d66e63b406bebe345a995c7481e825f8ec3c1e478::gtchantal2 {
    struct GTCHANTAL2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCHANTAL2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCHANTAL2>(arg0, 9, 0x1::string::utf8(b"GTCHANTAL2"), 0x1::string::utf8(b"Chantal Chui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/pY3wuvwShdHK3MV2Xi31I5ykuCHdlohAMu9a3kZMaqAy4UjE-q8p_XKw4mq7J9Fd9sPFTdYo-RzhntGRP4u8qwUBtxco2ttO8gvrHn1vuMyBYPy6zaEsy5zl5IJkAWqZq2mvYwUfUJxxX3TAOOgztBcDzAlyvfQvA20Ftc2CnLdlCwefASVHM4plNsFPYFM0hRsND-_lgBxJyjsFAWlb-NGksXnkN-JUpwNkVvC-P478hW4qCvBuf6KVaLuvf11lx9N6NJxT625I-balibHsIgE5X0bg9Nj2rCZd-m01umYWbfNnJEvuR81eAwr1I623Vcb3CrHLIfuw8v3VKiDylg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCHANTAL2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCHANTAL2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

