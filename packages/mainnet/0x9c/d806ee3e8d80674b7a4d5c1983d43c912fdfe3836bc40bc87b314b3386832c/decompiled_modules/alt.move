module 0x9cd806ee3e8d80674b7a4d5c1983d43c912fdfe3836bc40bc87b314b3386832c::alt {
    struct ALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6b7cab0a8e29de7209a672b9ed343fdcadc4f36f2d2bd2e0ba8456b986d679da                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ALT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ALT         ")))), trim_right(b"ALTURA                          "), trim_right(x"24414c543a2047686f7374204675656c0a0a5468652046697273742057617665206f66204469676974616c2043757272656e637920576974682046524545444f4d2046697273742c206261636b65642062792061206d61737369766520636f6d6d756e6974792065636f73797374656d20666f7220456e7472657072656e6575727320616e64204f6e6c696e65204275696c646572732e0a0a546865204b657920746f20416c747572612773205661756c74506179204f6e63652c204f776e20596f757220536861646f772e0a0a5374616b652024414c5420746f20756e6c6f636b20707269766163792d666972737420627573696e65737320746f6f6c733a20414920636f616368696e672c20766973696f6e20706c616e6e696e672c2066696e616e6369616c20747261636b696e672c20616e642063616c656e64617220"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALT>>(v4);
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

