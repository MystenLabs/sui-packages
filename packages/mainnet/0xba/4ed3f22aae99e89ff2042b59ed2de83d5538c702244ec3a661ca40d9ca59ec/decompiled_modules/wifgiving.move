module 0xba4ed3f22aae99e89ff2042b59ed2de83d5538c702244ec3a661ca40d9ca59ec::wifgiving {
    struct WIFGIVING has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFGIVING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"af686af2c2f349c96bcf6ece6ecc743dd6dc541102347204ef38cfaadc33f1a2                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WIFGIVING>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"wifgiving   ")))), trim_right(b"wifgiving                       "), trim_right(b"24/7 flywheel for charity. wifgiving is all about giving back to the unfortunate. together we can give back to world all while wearing a turkey hat.                                                                                                                                                                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFGIVING>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFGIVING>>(v4);
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

