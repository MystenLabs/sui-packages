module 0x3c01550ac4c000012640df27321da5f39f4978ad1b4c5dd9f8db330f98f154f7::jmp {
    struct JMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"gX4Y5J8LOgMgEd6E                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JMP         ")))), trim_right(b"JAYSON PENA                     "), trim_right(x"244a4d50200d0a50617274206f662074686520434d57204e6574776f726b200d0a416c736f2043726561746564200d0a50454e412045636f73797374656d20546f6b656e73200d0a24555344650d0a24434d570d0a245048494345580d0a244d414841524c494b410d0a244d43202d204d696c6c696f6e6169726520436c7562200d0a0d0a0d0a0d0a426f6e64696e6720557064617465200d0a342e352e3230323520202055706461746520776520617265204031322e38250d0a352e32332e323032352055706461746520776520617265204032312e30250d0a0d0a43656c6c2e3836302d3932342d303032380d0a0d0a0d0a41626f7574204a4d500d0a4a4d5020697320612063727970746f63757272656e6379207468617420706f776572732074686520434d57204e6574776f726b2e204a4d5020746f6b656e697a65"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JMP>>(v4);
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

