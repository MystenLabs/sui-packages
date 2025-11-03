module 0x84ad25a4ab01d2bb0602753ca87ae29ef157be09940ed014b9240aa7dd719103::bt2 {
    struct BT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BT2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://gateway.irys.xyz/CV1ZP7qZQ8CJPe45J9Qk3jaoz33MVSjCbvRmTGSf6WXZ                                                                                                                                                                                                                                                           ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<BT2>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BT2     ")))), trim_right(b"BLOCKTEST2                      "), trim_right(b"                                                                                                                                                                                                                                                                                                                                "), v2, true, arg1);
        let v6 = v3;
        0x2::coin::mint_and_transfer<BT2>(&mut v6, 20000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BT2>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BT2>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BT2>>(v5);
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

