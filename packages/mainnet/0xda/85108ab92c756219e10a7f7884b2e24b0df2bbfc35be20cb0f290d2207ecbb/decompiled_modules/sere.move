module 0xda85108ab92c756219e10a7f7884b2e24b0df2bbfc35be20cb0f290d2207ecbb::sere {
    struct SERE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SERE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SERE>>(0x2::coin::mint<SERE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SERE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x98100f6c24c5b4de5b5a4e9bfbbe05ed8d0f89fd.png?size=lg&key=b124a6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SERE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SERE    ")))), trim_right(b"Serene AI                       "), trim_right(b"Serene AI is a decentralized project that offers a Hedging Contracts operating platform. The goal is to provide to professional and asset owner investors a instrument for mitigating market prices volatility.                                                                                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SERE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SERE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SERE>>(0x2::coin::mint<SERE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

