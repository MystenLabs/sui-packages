module 0x4ac4a2074d6609ffc1da3951a5c3027f2c55183ae49e5ef1fc735fb85fabe265::murkai {
    struct MURKAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MURKAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MURKAI>>(0x2::coin::mint<MURKAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MURKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"An ancient mage. A wandering storm. And a grudge that outlasted his own death.                                                                                                                                                                                                                                                  ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MURKAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MURKAI  ")))), trim_right(b"MURKAI                          "), trim_right(b"https://cdn.dexscreener.com/cms/images/83wZL4Yb5iYaeCl1?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MURKAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MURKAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MURKAI>>(0x2::coin::mint<MURKAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

