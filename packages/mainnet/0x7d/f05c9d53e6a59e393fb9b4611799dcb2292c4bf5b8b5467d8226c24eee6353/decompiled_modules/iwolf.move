module 0x7df05c9d53e6a59e393fb9b4611799dcb2292c4bf5b8b5467d8226c24eee6353::iwolf {
    struct IWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"f1262bd459cf8b0fb10c951494e63f884bd238d47772e707a2abc0558b5c3724                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IWOLF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"IWOLF       ")))), trim_right(b"IronWolf                        "), trim_right(x"2049726f6e576f6c6620282449574f4c46292020537472656e6774682e2042726f74686572686f6f642e204d696e647365742e200a0a49726f6e576f6c66206973206d6f7265207468616e2061206d656d652e20497473206120646563656e7472616c697a6564206d6f76656d656e7420666f7267656420696e206469736369706c696e652c206c6f79616c74792c20616e6420666972652e20426f726e206f6e20536f6c616e612c202449574f4c4620626c656e647320656c69746520616573746865746963732077697468207265616c2d776f726c64207574696c697479202066726f6d206c696d69746564206d657263682064726f707320746f20686967682d696e74656e7369747920636f6d6d756e69747920776f726b6f7574732c206d696e6473657420636f6e74656e742c20616e6420667574757265206d6574"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWOLF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IWOLF>>(v4);
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

