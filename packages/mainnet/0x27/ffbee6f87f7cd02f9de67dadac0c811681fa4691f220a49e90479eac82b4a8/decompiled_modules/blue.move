module 0x27ffbee6f87f7cd02f9de67dadac0c811681fa4691f220a49e90479eac82b4a8::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://gateway.irys.xyz/KuTIVGn1Xb1wveRHRbfJzGPclApzZTO7Mtb5bh1-R7U                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BLUE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BLUE    ")))), trim_right(b"BlueFood Token                  "), trim_right(x"54686520776f726c642773206669727374207375737461696e61626c65204d6172696e65204171756163756c7475726520546f6b656e2028546f6b656e290a546f2070726f6d6f7465207375737461696e61626c6520626c756520666f6f6420646576656c6f706d656e7420616e64206d61696e7461696e206d6172696e65204171756163756c74757265207265736f75726365732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v4);
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

