module 0x6f884296139c890d859d7a542bec9fbebc3cb466e4ed6fda6c7f2cb91fd46f8e::lc {
    struct LC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/43YakhC3TcSuTgSXnxFgw8uKL8VkuLuFa4M6Bninpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LC          ")))), trim_right(b"LC SHIB                         "), trim_right(x"4c61756e636865642062792074686520666f72636520626568696e64204073686962746f6b656e2e0a244c43206675656c7320446567656e536166652020616e207570636f6d696e67206c61756e6368706164206275696c7420746f2070726f7465637420646567656e7320616e6420777265636b207363616d6d6572732e0a0a4275696c7420627920746865207472656e636865732e20466f7220746865207472656e636865732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LC>>(v4);
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

