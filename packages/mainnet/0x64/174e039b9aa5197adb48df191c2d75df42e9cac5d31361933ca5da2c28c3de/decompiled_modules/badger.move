module 0x64174e039b9aa5197adb48df191c2d75df42e9cac5d31361933ca5da2c28c3de::badger {
    struct BADGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9e43d53ebb2a2d7809192ae4d0a980ab300cf637d71a216b735db5584bfdd5ce                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BADGER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BADGER      ")))), trim_right(b"Badger Badger Badger            "), trim_right(x"2442414447455220697320696e737069726564206279206f6e65206f6620746865206d6f73742069636f6e6963206561726c792d696e7465726e6574206d656d65732020746865206c6567656e64617279204261646765722042616467657220426164676572207468617420746f6f6b206f76657220746865203230303073207765622e0a48657320746865206368756e6b792c2064616e63696e672c20756e73746f707061626c65206d656d6520637265617475726520746861742065766572796f6e6520736177206174206c65617374206f6e6365206261636b20696e207468652077696c6420466c6173682d616e696d6174696f6e20646179732e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADGER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADGER>>(v4);
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

