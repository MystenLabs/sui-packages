module 0x4fb18ac5315896a822f2b57debbc55d7042464312ade11c175834abd72e722f0::julie {
    struct JULIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JULIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ca12eb06f1ef1d4ffb328f2169ee8d15eaf4c27a1524daece9d176c135b8cbde                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JULIE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JULIE       ")))), trim_right(b"Justice for Dr. Julie Schnuelle "), trim_right(x"53415920484552204e414d453a2044722e204a756c6965205363686e75656c6c65200a0a53686520776173206b694949656420796573746572646179207768696c652077616c6b696e672068657220646f6720696e2041756275726e2c20416c6162616d612e20526173686164204461626e657920617272657374656420616e642063686172676564202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JULIE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JULIE>>(v4);
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

