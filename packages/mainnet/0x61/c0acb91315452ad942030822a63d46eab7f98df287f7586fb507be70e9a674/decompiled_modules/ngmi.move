module 0x61c0acb91315452ad942030822a63d46eab7f98df287f7586fb507be70e9a674::ngmi {
    struct NGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"PRBn5PKGpTVfYtmh                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NGMI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NGMI        ")))), trim_right(b"Now Gonna Make It               "), trim_right(x"244e474d49202d204e6f7720476f6e6e61204d616b65204974200d0a0d0a546865792073616964207765277265204e474d492e2054686579206c6175676865642e20546865792066616465642e20546865792066756d626c65642e0d0a0d0a42757420677565737320776861743f205468652073637269707420697320666c697070696e672e0d0a0d0a244e474d492069736e74206a7573742061206d656d652c206974732074686520756c74696d61746520646567656e20636f6d656261636b2073746f72792e2046726f6d2046554420746f20464f4d4f2c2066726f6d2065786974206c697175696469747920746f2073656e64696e6720697420737472616967687420746f2056616c68616c6c612e0d0a0d0a20437962657270756e6b2076696265732c20676c6974636820616573746865746963732c20616e642072"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGMI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGMI>>(v4);
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

