module 0xff10fbc35febdc2635c70630ec0047bc13ca6647d3a51558deb8c087f22ae24::human {
    struct HUMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"b4aa948df50e9bfde4f2b915ae343b7f2e6b63d687784bde3f23426f6cac62d3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HUMAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HUMAN       ")))), trim_right(b"Human 300                       "), trim_right(x"2448554d414e206973206e6f7420616e74692d41492e204974732070726f2d736f756c2e0a0a5768696c65206172746966696369616c20696e74656c6c6967656e6365207265706c6163657320776f726b6572732c202448554d414e206275696c64732061206d6f76656d656e7420726f6f74656420696e2077686174206d616368696e65732063616e206e65766572207265706c69636174653a20656d6f74696f6e2c20696e74756974696f6e2c20616e6420736f756c2e0a0a546869732069736e74206a7573742061206d656d65636f696e2e20497473206120726562656c6c696f6e2e0a0a4c65642062792048756d69652c2074686520736f756c206f662074686520726573697374616e63652020616e6420666f6c6c6f776564206279204374726c2c20686572206c6f79616c20414920636f6d70616e696f6e2020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUMAN>>(v4);
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

