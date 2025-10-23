module 0x4f8b9d6b16fbc08cadb6bea22dc6ffb9ad3681170d158ee9cf06059f8b5f323b::babyfloki {
    struct BABYFLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"f3c23cc0d195663b416fbc90a0c0a5effce0ef066a93ddd27f1c1ad754aaf675                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BABYFLOKI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BABYFLOKI   ")))), trim_right(b"BABYFLOKI                       "), trim_right(x"4261627920466c6f6b69206272696e67732061206e65772063757465207669626520666f7220466c6f6b692066616e732c2070616972696e6720637574656e6573732077697468206261646173732056696b696e6720656e657267792e2041206d61746368206d61646520696e2048656176656e206f722073686f756c64207765207361792056616c68616c6c612e200a0a546869732056696b696e672070757020697320726561647920746f20726169642e2057686f2073617973206261626965732063616e2774206265206261646173733f20284f6820616e6420696e6361736520796f75206469646e74206b6e6f772c20466c6f6b6920697320616c736f20456c6f6e204d75736b7320646f6720616e64207468652043454f206f66205820426f7373204261627920766962657320616e796f6e653f29200a0a4e6576"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYFLOKI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYFLOKI>>(v4);
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

