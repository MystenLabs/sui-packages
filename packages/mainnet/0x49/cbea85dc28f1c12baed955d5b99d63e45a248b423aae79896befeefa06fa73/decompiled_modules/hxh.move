module 0x49cbea85dc28f1c12baed955d5b99d63e45a248b423aae79896befeefa06fa73::hxh {
    struct HXH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HXH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3vELZk6gPdp9Yc9xL7oCq81C8X9mRyy6httJ3qQQpkUv.png?claimId=O-ZbhVtJXkhfLUQ9                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HXH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HXH         ")))), trim_right(b"Hunter X Hunter                 "), trim_right(x"24485848202054686520756c74696d6174652048756e74657220782048756e746572206d656d65636f696e21204561726e2024536f6c207468726f75676820796f75722048756e7465722066616e646f6d2120204a6f696e207468652068756e742c206177616b656e20796f7572204e656e202620636c61696d20796f757220747265617375726521200a0a54686520636f6d6d756e697479206c69766573206f6e20582120204368616c6c656e6765732c206769766561776179732c20616e6420616c6c207468696e6773204878482d2d20404878485f536f6c0a0a4561726e20796f75722048756e7465722773204c6963656e73652c204a6f696e20746865205068616e746f6d2054726f7570652c20616e64206a6f696e206120776f726c647769646520636f6d6d756e69747921202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HXH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HXH>>(v4);
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

