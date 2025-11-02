module 0x80354033a705fc5bef3fec8cf29e6a8b143727d2528029407ab14709605b327f::ma {
    struct MA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1651f25747c665e67c6f93edf2feb951a51cddc6903a0337e4a807df922af2f1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MA          ")))), trim_right(b"Matys Coin                      "), trim_right(x"5768617420697320244d413f0a4d6174797320436f696e2028244d41292069736e74206a75737420616e6f7468657220746f6b656e20206974732061206d6f76656d656e7420666f7220647265616d6572732c2062656c6965766572732c20616e6420747261646572732077686f206d697373656420446f676520616e6420424f4e4b2062757420776f6e74206d6973732074686973206f6e652e0a0a4275696c74206f6e2074686520536f6c616e6120626c6f636b636861696e2c204d6174797320436f696e206973206120666173742c207365637572652c20616e6420636f6d6d756e6974792d64726976656e206469676974616c2061737365742064657369676e656420666f7220746865206e6578742067656e65726174696f6e206f6620646563656e7472616c697a656420696e6e6f766174696f6e2e2057697468"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MA>>(v4);
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

