module 0x6185bb30789e19e5e6c0719d7bb028ea821bf69c019008953a017811d9466208::pixai {
    struct PIXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4frsz44mgqRQ46nuU19T96sH8964wqRVL1P2ktDGpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PIXAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PIXAI       ")))), trim_right(b"Pix AI                          "), trim_right(x"546865206d6f737420616476616e636564204149202620636f6d706c6574656c79206672656520666f7220616c6c2024504958414920686f6c64657273210a0a20556c7472612d616476616e63656420696d6167652067656e65726174696f6e0a20486967686c79207265616c697374696320766964656f2067656e65726174696f6e0a20412066756c6c7920747261696e6564207465726d696e616c20746f206d65657420616c6c20796f7572206e656564730a0a416e64206d756368206d6f72652e2e2e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXAI>>(v4);
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

