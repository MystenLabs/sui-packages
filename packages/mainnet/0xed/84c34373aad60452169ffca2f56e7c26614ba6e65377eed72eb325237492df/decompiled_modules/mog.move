module 0xed84c34373aad60452169ffca2f56e7c26614ba6e65377eed72eb325237492df::mog {
    struct MOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"07f455843fb7fd013eb761a53e8e0951a577d1a36a5d9a74b770d1de79fe9dfa                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOG         ")))), trim_right(b"Mother of God                   "), trim_right(b"Mother of God is a rage comic character of a man staring intently at something as he takes his sunglasses off. It can be also used outside of rage comics to express astonishment or disbelief in response to a shocking image or a video. Similar to the colloquial usage of the phrase, the reaction face can be used to eithe"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOG>>(v4);
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

