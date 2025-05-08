module 0xf2262bbba234844bd8f33e6fad725fa4a4a706302a6bb91570ed452775d33327::mctrumpa {
    struct MCTRUMPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCTRUMPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BQwYE9jDG8MmLNrTY82J8Lq63YGR6namdpBERckEpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MCTRUMPA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"McTrump     ")))), trim_right(b"McBarron$                       "), trim_right(x"5354524149474854205550204d454d4520436f696e212120544845204e45585420424947205452554d502046414d494c5920434f494e0a2062757920796f7572204d63426172726f6e206d65616c20535550455253495a4544204e4f57204f5220524547524554204954204c41544552212121204d435452554d502f4d43424152524f4e204d45414c5320464f522045564552594f4e4521210a57452057454c434f4d4520414c4c20414e442041524520412046554e20434f4d4d554e495459204255542057494c4c204e4f5420544f4c4552415445204e454741544956495459204f522056554c47415249545920544f5741524453204f54484552204d454d424552532e20494620594f55275245204845524520464f522054484520444f4c4c4152204d454e553f20594f5527524520494e205448452057524f4e4720504c"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCTRUMPA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCTRUMPA>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

