module 0x4f301ef5c46fe7cca95725a50e82017cda8269e90450b76b0de4ffbd2c3c8afa::army {
    struct ARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"bcda8fabf85f71ee433692a9a3d7d2bdd0a236d7406d4f083e266034cc6a4520                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ARMY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ARMY        ")))), trim_right(b"ARMY                            "), trim_right(x"4a4f494e205448452041524d590a0a417474656e74696f6e20736f6c646965722e2046726f677320616e6420746f61647320746f676574686572206172652063616c6c656420616e2041726d792e20596f75722062726f746865727320616e6420736973746572732061726520616c726561647920696e20746865207472656e636865732e204974732074696d6520746f206a6f696e207468656d2e20536f6f6e2077652077696c6c2072756c652065766572792074696d656c696e652c20746f70206576657279206c6561646572626f6172642c20616e642074616b6520746865207472656e63686573206f6e636520616e6420666f7220616c6c2e0a0a576520666967687420666f7220676c6f72792e20576520666967687420666f722062726f74686572686f6f642e20576520666967687420666f7220686f6e6f722e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARMY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARMY>>(v4);
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

