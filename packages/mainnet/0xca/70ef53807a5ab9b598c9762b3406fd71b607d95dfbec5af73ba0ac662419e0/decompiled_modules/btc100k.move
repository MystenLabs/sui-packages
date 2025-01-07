module 0xca70ef53807a5ab9b598c9762b3406fd71b607d95dfbec5af73ba0ac662419e0::btc100k {
    struct BTC100K has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BTC100K>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BTC100K>>(0x2::coin::mint<BTC100K>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BTC100K, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9cBShSYUmNRxHohfz2Nb4Gyt6jnZq7WKrZp9kssdECrS.png?size=lg&key=8d07aa                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTC100K>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTC100K ")))), trim_right(b"Bravo BTC100K                   "), trim_right(b"Over 100K USD                                                                                                                                                                                                                                                                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC100K>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BTC100K>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BTC100K>>(0x2::coin::mint<BTC100K>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

