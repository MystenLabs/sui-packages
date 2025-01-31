module 0x556ca15c54ac69b74a73aa29e79ae629ff5e42ff7b4b9b30b8e43fd14c9ac22d::lux {
    struct LUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BmXfbamFqrBzrqihr9hbSmEsfQUXMVaqshAjgvZupump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LUX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LUX         ")))), trim_right(b"Lux Token                       "), trim_right(x"4c75783a20546865204d756c7469706c6179657220496e7465726e65742c204120556e69666965642057617920746f204e617669676174652074686520496e7465726e6574206f6e20426c6f636b636861696e20546563686e6f6c6f67792e20556e6c6f636b204d756c7469706c617965722042726f7773696e672e204578706c6f72652061204469676974616c20556e69766572736520436f6d706f736564206f6620536861726564204f6e6c696e65205370616365732e0a0a2057697468204c75782065766572792077656273697465207472616e73666f726d7320696e746f206120756e6971756520706c616e65742066696c6c65642077697468206163746976697469657320616e64206d756c7469706c617965722066656174757265732e205468697320697320746865206f6e6c79206f7665726c617920796f75"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUX>>(v4);
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

