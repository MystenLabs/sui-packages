module 0x2edd3b8309bc98f169ce8abad98cce2bbec6949ff9e22b93aacf3546886e3a84::iryna {
    struct IRYNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRYNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"d576e6ba778fb602ddd82be6bf8d9c0860ce43cd8418ca605d12a193d281468a                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IRYNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"IRYNA       ")))), trim_right(b"Justice for Iryna               "), trim_right(b"Justice for Iryna! On August 22, 2025, Iryna Zarutska a 23-year-old Ukrainian refugee who fled war in search of safety was senselessly stabbed to death by a stranger aboard a Charlotte light-rail train. The attack was random and unprovoked; footage captured the horror as she was stabbed three times in the neck and ches"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRYNA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRYNA>>(v4);
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

