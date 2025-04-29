module 0x650bcabd9c833c51c10c9ac1048e6335e070c9a27d9534d04fb8388dca8cb654::zkai {
    struct ZKAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZKAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZKAI>>(0x2::coin::mint<ZKAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x5959e94661e1203e0c8ef84095a7846bacc6a94f.png?size=lg&key=68314b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZKAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZKAI    ")))), trim_right(b"ZKCrypt AI                      "), trim_right(b"ZKCryptAI offers unique solutions leveraging decentralized machine learning and zero-knowledge protocols, to prevent unintended data exposure and ensure user privacy and data integrity while using Autonomous AI agents and general-purpose AI applications.                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZKAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZKAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZKAI>>(0x2::coin::mint<ZKAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

