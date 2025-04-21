module 0x541aca1311ea78e9eaf2a9e22e0fd0a59968b74f9116865d7f1a1f6dd5eb5b30::trumpman {
    struct TRUMPMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Aygpsdr1BvL5dYjZnt8nzz1n73Ev7t7MXmfA2Z9Xpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUMPMAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRUMPMAN    ")))), trim_right(b"Trumpman: Season 1              "), trim_right(x"5472756d706d616e3a20536561736f6e20312028245452554d504d414e290a0a40446567656e436f6c6c656374494f2070726573656e74733a200a0a5472756d706d616e3a20536561736f6e20312028245472756d706d616e29205468652063727970746f63757272656e6379207468617420656d626f646965732074686520737069726974206f66206865726f69736d20616e6420747275746820696e20746865206469676974616c206167652e204c65642062792074686520696e646f6d697461626c65204461726b20446f6e2c20612062696c6c696f6e61697265207475726e656420666561726c65737320646566656e646572206f662066726565646f6d20616e64206a7573746963652c20616c6f6e67207769746820686973207472757374656420667269656e6420616e6420636f6e666964616e74204d75736b"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPMAN>>(v4);
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

