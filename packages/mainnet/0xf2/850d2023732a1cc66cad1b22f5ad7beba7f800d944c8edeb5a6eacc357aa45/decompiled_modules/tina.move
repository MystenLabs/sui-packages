module 0xf2850d2023732a1cc66cad1b22f5ad7beba7f800d944c8edeb5a6eacc357aa45::tina {
    struct TINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5BVgGpZeF7uAiv4j9ZNmqMMv9xMuAzUAEScXDwJapump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TINA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TINA        ")))), trim_right(b"the dog who changed the world   "), trim_right(x"54696e6120697320646f67207468617420686173207472756c79206368616e6765642074686520776f726c6420616e64206c6566742061206c656761637920746861742077696c6c207361766564203130302c30303073206f66206f7468657220646f67732e0a0a53746572696c697a65642038302c30303020646f67732073746f7070696e6720636c6f736520746f2061206d696c6c696f6e2070757070696573206265696e6720626f726e0a466564206f766572203530302c3030302066726573686c7920636f6f6b6564206d65616c730a52652d686f6d656420373520646f67732061726f756e642074686520776f726c640a4275696c7420686572206669656c6420686f73706974616c2028496e20746865206261636b67726f756e64290a547265617465642068756e6472656473206f66207369636b7320646f67"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINA>>(v4);
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

