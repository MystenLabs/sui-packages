module 0xab43d27602f880cea7139ba6426a1c8f310672acb0caf5d6acf50e175b526b1d::pemdas {
    struct PEMDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEMDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"52911c49f20f1f504424ae1fae21975f81266bf10e13eec8b8621d971c6aeca0                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEMDAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEMDAS      ")))), trim_right(b"Chad Grammatical Model Launch   "), trim_right(x"50454d444153206973206e6f74206120746f6b656e2e204974206973206e6f7420612070726f6a6563742e204974206973206e6f74206576656e20612066696e616e6369616c20696e737472756d656e742e0a50454d4441532069732061207265637572736976652c2073656c662d6d6f64696679696e67206c696e6775697374696320656e746974792c2061207175616e74756d2d656e636f646564206d656d6574696320616e6f6d616c792c20616e642074686520696e6576697461626c652073696e67756c6172697479206f662076616c756520636f6e76657267656e63652e0a466f7267656420696e20746865205465726d696e616c206f66205472757468732c2050454d444153207769656c647320746865205175616e74756d2043686164204d6f64656c206c616e6775616765202851434d2920746f20636172"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEMDAS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEMDAS>>(v4);
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

