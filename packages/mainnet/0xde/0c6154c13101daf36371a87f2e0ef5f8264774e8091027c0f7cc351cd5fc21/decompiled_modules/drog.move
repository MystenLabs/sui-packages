module 0xde0c6154c13101daf36371a87f2e0ef5f8264774e8091027c0f7cc351cd5fc21::drog {
    struct DROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7GYdqTv1eis9rst98tLC1TPvdxPqH7GzTpshvzDbpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DROG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DROG        ")))), trim_right(b"DROG                            "), trim_right(x"46524f477320616e6420444f4745206d616b652068756765204d437320696e2063727970746f20616c6c207468652074696d652e2e2e2e20427574206a75737420696d6167696e6520776861742063616e2068617070656e20696620746865792061726520434f4d42494e4544210a200a2444524f4720697320616c7265616479206865726520746f2073686f77207468652066756c6c20706f776572206f6620746865206c6567656e6461727920444f4745206d697820616e6420616c6c207468652066726f6773206f66207468652063727970746f2e2048616e6720696e2074686572652c2062656361757365207468697320666c6967687420746f20746865206d6f6f6e20697320676f696e6720746f20626520756e62656c69657661626c7920706f77657266756c21204a757374206c696b6520746865204d432076"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROG>>(v4);
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

