module 0xf3139a6b70d274043a764b1a10021d7cc082ecdaf40209da4245e81ac76ced9::audit {
    struct AUDIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3s6ybDWyHfy9nJMQvhbhhR68pUuy4vzbQg7qCaJYpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AUDIT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AUDIT       ")))), trim_right(b"AuditX                          "), trim_right(x"41756469745820546f6b656e0a546865206e61746976652063757272656e6379206f662041756469745820414920206120536f6c616e61206d656d65636f696e20706f776572696e67207265616c2d74696d652c20626c6f636b636861696e2d6e617469766520414920616e616c797369732e20417564697458206c657665726167657320616476616e636564206d616368696e65206c6561726e696e6720746f20756e636f7665722068696464656e2066696e616e6369616c207269736b732c20736d61727420636f6e74726163742076756c6e65726162696c69746965732c20616e6420676f7665726e616e636520666c617773206163726f737320626f7468206469676974616c20616e64207265616c2d776f726c642065636f73797374656d732e205769746820696e7465726e65742061636365737320616e64206c"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUDIT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUDIT>>(v4);
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

