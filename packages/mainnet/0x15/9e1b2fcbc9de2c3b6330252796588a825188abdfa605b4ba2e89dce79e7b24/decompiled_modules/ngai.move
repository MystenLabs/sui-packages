module 0x159e1b2fcbc9de2c3b6330252796588a825188abdfa605b4ba2e89dce79e7b24::ngai {
    struct NGAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NGAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NGAI>>(0x2::coin::mint<NGAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7JTSCMJR1FumTZxXeV1U142epQ8WejdCAYVz2aGspump.png?size=lg&key=cf9410                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NGAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NGAI    ")))), trim_right(b"Name Gen Ai                     "), trim_right(b"Name Gen AI: Your go-to Sui wallet generator. Create secure, custom wallets with ease.                                                                                                                                                                                                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NGAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NGAI>>(0x2::coin::mint<NGAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

