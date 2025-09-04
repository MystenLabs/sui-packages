module 0xfdfbacce98b910d991fa8e57301f3480f06c418dbdfe6c1f233c6e4cfba30c4a::if {
    struct IF has drop {
        dummy_field: bool,
    }

    fun init(arg0: IF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8b74dfa75f4e27c942ec617b7437bdca32218cd3ecbf42e2e8a11179c8f8d3d4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"IF          ")))), trim_right(b"IF                              "), trim_right(x"4946206973206e6f74206a7573742061206d656d6520746f6b656e200a20697427732061206d656d6574696c697479206578706572696d656e7420776865726520656d6f74696f6e7320617265206e6f74207761737465642c200a627574207472616e73666f726d65642e204275696c742061726f756e6420746865206861756e74696e67207175657374696f6e206f6620776861742069662c200a6974207475726e7320756e7265616c697a65642063686f6963657320616e642073696c656e74207265677265747320696e746f207969656c642d62656172696e6720616374696f6e732e200a5468726f75676820656d6f74696f6e616c207374616b696e672c20706172616c6c656c2073656c662d646973636f766572792c200a616e642067616d69666965642076616c75652073797374656d732c200a494620657870"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IF>>(v4);
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

