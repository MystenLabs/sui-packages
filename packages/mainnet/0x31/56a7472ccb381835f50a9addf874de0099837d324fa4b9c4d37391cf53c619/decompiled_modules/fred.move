module 0x3156a7472ccb381835f50a9addf874de0099837d324fa4b9c4d37391cf53c619::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9f9f725cc7aa77905130a1eba307355464274c526e03a069e281c1035612d155                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FRED>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FRED        ")))), trim_right(b"fred the kitty                  "), trim_right(x"6865792068656c6c6f2065766572796f6e652020696d20746865206b69747479202446524544200a0a49206d69676874206265206e657720746f20796f752c20627574206920776173207265736375656420612066657720646179732061676f206279206d792068756d616e20677561726469616e20616e67656c202040537175697272656c5f446164313220202c207468617420616c736f207361766564206d792062726f746865727320696e2074686520706173742e2e2020504e55542074686520737175697272656c20616e642020204652454420746865207261636f6f6e2e2e202062757420756e666f7274756e6174656c79202c207468657920617265206e6f7420616d6f6e6720757320616e796d6f7265207361646c79200a0a42555420494d205354494c4c2048455245212020616e64206974732074696d65"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRED>>(v4);
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

