module 0xfba6764c73fce8ff8649318a58c36473ba51bee6548b0c82fbd7739c95cc57ce::ioq {
    struct IOQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IOQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3f25e7e825317a969894cd5ba113fc193a69a5cbf920402937dd4f42b0865cf4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IOQ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"iOQ         ")))), trim_right(b"iOQ Wallet                      "), trim_right(x"205768617420697320694f512057616c6c65743f0a0a694f512069732061207365637572652c20696e74656c6c6967656e742c206e6f6e2d637573746f6469616c207765622077616c6c65742064657369676e656420666f7220746865206e6578742065766f6c7574696f6e206f6620646563656e7472616c697a65642066696e616e636520616e64206469676974616c206964656e746974792020706f77657265642062792041492c206f7074696d697a656420666f72206d756c74692d636861696e207573652c20616e64206275696c742077697468206675747572652d72656164792063727970746f6772617068792e0a0a4d616e79204d6f726520466561747572657320746f20436f6d6521202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IOQ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IOQ>>(v4);
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

