module 0x4738243eeed83ff1fb780cc778e8a52180bc2668ba8edcd81017adb0d50fd147::rizzmare {
    struct RIZZMARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZMARE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8c484c90aa0bf3568b6b9c239fdfa0a2384b61d14a5d0b0d6d5dea91aa60617a                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RIZZMARE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RIZZMARE    ")))), trim_right(b"NIGHTMARE BEFORE RIZZMAS        "), trim_right(x"204e696768746d617265204265666f72652052697a7a6d617320282452495a5a4d41524529200a0a496e206120776f726c6420776865726520686f6c69646179206368656572206d6565747320756c74696d6174652072697a7a2c204a65726f6d6520536b656c6c696e67746f6e2072697365732066726f6d207468652063727970742077697468206f6e6520676f616c3a20737465616c2052697a7a6d61732066726f6d2053616e746120616e6420636c61696d207468652063726f776e206f6620736d6f6f74686e6573732e0a0a2452495a5a4d4152452069736e74206a757374206120636f696e697473206120686f6c696461792068656973742066696c6c656420776974682073706f6f6b792076696265732c204368726973746d6173206368616f732c20616e64206d617865642d6f7574206368617269736d612e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZMARE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZMARE>>(v4);
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

