module 0x64a9035a6fc9245beee9672ea803d799a8cfb731a3f46c7ef59962ed08078032::mewwar {
    struct MEWWAR has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEWWAR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MEWWAR>>(0x2::coin::mint<MEWWAR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MEWWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7e5DEqCkdDfYFXyG67hiCyUcjuhdGvYcqWTvZtkjpump.png?size=lg&key=a1f60c                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MEWWAR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MEWWAR  ")))), trim_right(b"Mew Warrior                     "), trim_right(x"54776f206865617274732e204f6e65206c6f76652e20456e646c65737320707572727320616e6420736e7567676c65732e20536f6d6520736179206c6f76652069732073776565742e2057652073617920697473206576656e2073776565746572207768656e207765726520746f6765746865722c207368617270656e696e67206f757220636c61777320616e6420737465616c696e672065616368206f7468657273207472656174732c20616c6c207768696c65206265696e6720746865206375746573742070616972206f6620636174732061726f756e642e0020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWWAR>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEWWAR>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEWWAR>>(0x2::coin::mint<MEWWAR>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

