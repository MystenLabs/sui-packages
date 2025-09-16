module 0x3bad054e296e61cd21f311435eba40fa764b19f086c5d9c0a3f492ffeab6168e::lorde {
    struct LORDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORDE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5ea7d7c49a15353be500139eebc507cd2d24418fe08af3885aec9f8261b9eb8c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LORDE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LORDE       ")))), trim_right(b"LORDECOIN                       "), trim_right(x"4c6f72646520436f696e2069732061205265616c20576f726c6420417373657420285257412920746f6b656e20706f77657265642062792074686520696e666c75656e6365206f6620766972616c2054696b546f6b6572204e697a7a79436f6e737069726163792e204275696c7420666f7220746865206e65772077617665206f662073747265616d696e672c206974207472616e73666f726d7320636f6e74656e7420616e6420636f6d6d756e69747920696e746f207265616c2076616c75652c20676976696e6720686f6c646572732061207374616b6520696e2074686520657870657269656e63652065636f6e6f6d792e0a54686f73652077686f2062757920646f6e2774206a75737420686f6c64206120636f696e2d7468657920617363656e6420746f206265636f6d652061204c6f72646520696e207468656972"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORDE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORDE>>(v4);
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

