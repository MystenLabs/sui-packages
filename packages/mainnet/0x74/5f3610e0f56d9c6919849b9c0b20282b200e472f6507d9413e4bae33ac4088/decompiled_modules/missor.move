module 0x745f3610e0f56d9c6919849b9c0b20282b200e472f6507d9413e4bae33ac4088::missor {
    struct MISSOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISSOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FAcgHxSyjJwiXHhk8JerMopDiespQigjs3T9DLfqpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MISSOR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MISSOR      ")))), trim_right(b"Don't Be A Missor               "), trim_right(x"4c696b6520696e206120636f75706c65206f662066756b6b696e6720646179732c20746865206d61726b6574206a75737420646965642e2e2e2e2e200a0a576861742773206974206c696b6520666f7220616c6c206f662075733f2043414c4d20444f574e2e20596f75206c6f6f6b206174206120636861727420616e642065766572797468696e6720736872696e6b7320696e736964652c2070616e696320636f6d657320706f7572696e67206f75742e2049742773204d6973736f72202d20746865207374617465206f66206d696e642074686174206d616b657320796f752077616e7420746f2073656c6c2065766572797468696e672c207468726f77206177617920796f75722070686f6e652c20616e6420666f7267657420796f75206576657220656e74657265642063727970746f20696e207468652066697273"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISSOR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISSOR>>(v4);
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

