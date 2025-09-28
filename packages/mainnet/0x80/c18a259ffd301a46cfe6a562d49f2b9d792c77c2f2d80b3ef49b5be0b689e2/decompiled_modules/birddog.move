module 0x80c18a259ffd301a46cfe6a562d49f2b9d792c77c2f2d80b3ef49b5be0b689e2::birddog {
    struct BIRDDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ef164229f63af920a2246fe103a0c97ec45da6de8f536494a7fa8dfc9554da16                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BIRDDOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BIRDDOG     ")))), trim_right(b"BIRDDOG                         "), trim_right(x"42697264446f67207374617274656420617320612073696d706c65206d656d65206f6e20536f6c616e617320626c6f636b20207461696c2077616767696e672c20766962657320666c6f77696e672c20616e642061207061636b20666f726d696e672e20486f77657665722c207768656e2074686520646576656c6f706572206162616e646f6e6564207468652070726f6a6563742c206d6f737420746f6b656e7320776f756c64206861766520666164656420696e746f206f62736375726974792e2042697264446f67206469646e742e2054686520636f6d6d756e697479207265667573656420746f206c65742068696d206469652e0a0a54686973206973206e6f77206120436f6d6d756e6974792054616b656f766572202843544f292c20776865726520686f6c6465727320616e642062656c696576657273206861"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDDOG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDDOG>>(v4);
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

