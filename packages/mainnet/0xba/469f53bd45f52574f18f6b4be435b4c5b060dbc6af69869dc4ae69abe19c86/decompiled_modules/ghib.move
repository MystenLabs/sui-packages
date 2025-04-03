module 0xba469f53bd45f52574f18f6b4be435b4c5b060dbc6af69869dc4ae69abe19c86::ghib {
    struct GHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"OM82ZRwXCehzHB--                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GHIB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GHIB        ")))), trim_right(b"GhibliCoin                      "), trim_right(x"476869626c69436f696e206973206120686561727466656c74207472696275746520746f207468652074696d656c657373206d61676963206f662053747564696f20476869626c692020636170747572696e672074686520776f6e6465722c206e6f7374616c6769612c20616e6420696d6167696e6174696f6e207468617420696e7370697265642067656e65726174696f6e732e2047484942206272696e677320746f67657468657220616e696d652066616e732c20647265616d6572732c20616e642063727970746f20616476656e74757265727320696e746f206f6e6520656e6368616e74656420636f6d6d756e6974792e0d0a0d0a5768657468657220796f75726520666c79696e67207769746820486f776c206f72206368696c6c696e67207769746820546f746f726f2c20476869626c69436f696e2069732079"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHIB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHIB>>(v4);
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

