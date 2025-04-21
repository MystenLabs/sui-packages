module 0x68c74c72ee01b6caffe7204b8cd6934f9921d4fa90a3eed2da5dc40192afe592::tradiecoin {
    struct TRADIECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRADIECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"fumLUi8z6mdBEgFQ                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRADIECOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TradieCoin  ")))), trim_right(b"TradieCoin                      "), trim_right(x"41204d656d6520636f696e2062617365642061726f756e64205472616469657320417573736965207472616465736d656e20726561647920746f20756e6974652077697468207472616469657320616e6420747261646965206c6f7665727320616c6c2061726f756e642074686520776f726c642e200d0a0d0a54726164696573207265616c6c7920646f206e6565642068656c702c2061206c6f74206f66207468656d20776f6e74206576656e206c697374656e20746f2074686520776f72642063727970746f21204c657473206d616b652073757265207468657920646f6e7420676574206c65667420626568696e6420616e642068656c70207468656d20756e6465727374616e6420746865206368616e67696e6720776f726c642061726f756e64207468656d21205768617420612067726561742077617920746f20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRADIECOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRADIECOIN>>(v4);
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

