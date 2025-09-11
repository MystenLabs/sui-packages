module 0xfb53b77d5d4aed7db9dc0ee99a857b27afd9e1bb478477053b39037dc0dc7d7e::broken {
    struct BROKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8c8c54c02a15d61fdea4f39d06db27457c42bfbd7edc2432fb7cef606845ebec                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BROKEN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BROKEN      ")))), trim_right(b"Society is                      "), trim_right(x"497420616c6c206665656c7320737472616e67652c206c696b65206120676f6f6420636f7079206f6620736f6d657468696e67207468617420776173206f6e6365207265616c2e200a5765726520746865206368696c6472656e206f6620612062726f6b656e20736f63696574792e0a0a0a0a4e4556455220464f5247455420544841540a546865792077616e7420796f752062726f6b652e0a546865792077616e7420796f7520646561642e0a546865792077616e7420796f7572206b69647320627261696e7761736865642e0a416e642074686579207468696e6b20697427732066756e6e792e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROKEN>>(v4);
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

