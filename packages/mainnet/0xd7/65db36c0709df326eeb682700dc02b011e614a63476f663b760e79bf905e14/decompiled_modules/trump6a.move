module 0xd765db36c0709df326eeb682700dc02b011e614a63476f663b760e79bf905e14::trump6a {
    struct TRUMP6A has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP6A, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5T2kRTnXGGdfsjsY7zNMrhoVvXKWVFt8MRMVZDk7pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUMP6A>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Trump6      ")))), trim_right(b"Trump6                          "), trim_right(x"496e206120776f726c64206f6620706f6c69746963616c206368616f732c206d656d6520776172666172652c20616e642063727970746f206d6f6f6e73686f74732c206f6e6520636f696e2069732061626f757420746f20627265616b2074686520696e7465726e65742e20496e74726f647563696e67205472756d70203620206120686967682d6f6374616e652c206f70656e2d776f726c64206d656d6520746f6b656e20776865726520746865206d61696e20636861726163746572206973206c6f75646572207468616e206120352d737461722077616e746564206c6576656c2e0a0a546869732069736e74206a75737420616e6f746865722073686974636f696e2e0a49747320612073617469726963616c206d61737465727069656365206275696c74206f6e20687970652c20686561646c696e65732c20616e64"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP6A>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP6A>>(v4);
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

