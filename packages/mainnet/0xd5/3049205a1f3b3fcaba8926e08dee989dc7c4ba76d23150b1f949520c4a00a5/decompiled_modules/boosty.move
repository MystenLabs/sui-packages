module 0xd53049205a1f3b3fcaba8926e08dee989dc7c4ba76d23150b1f949520c4a00a5::boosty {
    struct BOOSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"09a1555983b13c38224575b13bfcc6e53560b35e5fe627c78b0ff1c259a63fd1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOOSTY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"boosty      ")))), trim_right(b"boosty                          "), trim_right(x"426f6f7374792077617320626f726e20696e20746865206368616f73206f66206d656d65636f696e732061206d697363686965766f75732063726561747572652077697468206f6e65206f6273657373696f6e3a20626f6f737420666f72657665722e0a45766572792066656520676f657320737472616967687420696e746f2044657873637265656e657220626f6f7374732e0a497420646f65736e7420736c6565702c20646f65736e7420636172652061626f75742070726f66697473206576657279207472616465206d616b6573206974207374726f6e6765722e0a426f6f7374792069736e74206a7573742061206d6173636f742c206974732074686520656e67696e652074686174206b656570732070757368696e6720746865636861727475702e20202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOSTY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOSTY>>(v4);
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

