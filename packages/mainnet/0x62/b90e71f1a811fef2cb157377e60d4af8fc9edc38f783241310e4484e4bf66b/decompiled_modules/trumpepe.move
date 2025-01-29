module 0x62b90e71f1a811fef2cb157377e60d4af8fc9edc38f783241310e4484e4bf66b::trumpepe {
    struct TRUMPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CtxjFfYCcxxtxr7rYxk7D2RWqeAAUge4rqUsiDhZuCd8.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUMPEPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRUMPEPE    ")))), trim_right(b"PEPE TRUMP                      "), trim_right(x"57652061726520616c6c2061206c6974746c6520626974205472756d506570652c20616e6420697427732074686973206469766572736974792074686174206d616b657320416d65726963612067726561742e20456d62726163652077686f20796f75206172652c2063656c656272617465206f757220756e697175656e6573732c20616e64206c6574277320776f726b20746f67657468657220746f206d616b6520416d657269636120677265617420616761696e2e0a49742773205472756d506570652077686f2077696c6c206d616b6520416d657269636120677265617420616761696e2e20456d62726163652074686520737069726974206f66205472756d506570652c2063656c656272617465206f757220756e697175656e6573732c20616e64206c6574277320756e69746520746f206272696e672067726561"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPEPE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPEPE>>(v4);
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

