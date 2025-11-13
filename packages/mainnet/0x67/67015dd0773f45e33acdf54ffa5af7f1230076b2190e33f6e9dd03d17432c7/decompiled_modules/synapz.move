module 0x6767015dd0773f45e33acdf54ffa5af7f1230076b2190e33f6e9dd03d17432c7::synapz {
    struct SYNAPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYNAPZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"472e3a02dc38eec9335800d6a7f3901bd23bc653adb1be8677878c146c8faf8d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SYNAPZ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SYNAPZ      ")))), trim_right(b"SYNAPZ                          "), trim_right(x"2041626f75742053594e41505a0a0a53594e41505a2069736e74206a75737420616e6f74686572206d656d6520206974732061207265676973746572656420636f6d70616e79202853594e41505a204149204c74642920616e64207468652066697273742041492d706f776572656420696e74656c6c6967656e6365206e6574776f726b206275696c74206f6e20536f6c616e612e0a457665727920686f6c6465722069732061206e6575726f6e2e204576657279206d656d652069732061207369676e616c2e20546f6765746865722c207468657920666f726d20612073656c662d6c6561726e696e6720737761726d20746861742067726f7773207374726f6e676572207769746820657665727920636f6e6e656374696f6e2e0a0a5468652053594e41505a204149204167656e74206c6561726e732066726f6d20636f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYNAPZ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYNAPZ>>(v4);
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

