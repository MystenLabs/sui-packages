module 0x215f4653db8ed36b67ad7ec998306a983bf657d466533c5a5ba63ee45c503d2a::gtstarkbtc {
    struct GTSTARKBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSTARKBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSTARKBTC>(arg0, 9, 0x1::string::utf8(b"GTSTARKBTC"), 0x1::string::utf8(b"Stark Btc"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/gYRFHPlHaf70HrjeqnW8n-9S919MeRqO5R_6Vd-YRIcjg6hByXfw6eBCUr1ZB9mNj6Bt3j3IT4HU1rfbhkjsSClDfkg0sbC4nkiL15lAV6aGw1QNxBM1qPgYgcWe0pDIdGbz42s8qLecl5iQJpbsHK-rp_KJz_skxtIoR6L46o5GSc0naPyTzCTwOBPoTbwP5Dr9mbhFHmHbjSVg99BGWkYQwg_ttKsQYaGe3sQQZ0bM3mrLkCHhcuSADwss8opOQNoy4iiZWpOgti9lHJQN5SEvA5mMTTC8v7DhkQuaVMpj7kJnvZAopJxP58inA00cCyEFaDiNwKSfv2fyukWwJw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSTARKBTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSTARKBTC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

