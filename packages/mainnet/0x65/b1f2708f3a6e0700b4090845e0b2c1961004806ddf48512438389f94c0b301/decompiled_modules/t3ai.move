module 0x65b1f2708f3a6e0700b4090845e0b2c1961004806ddf48512438389f94c0b301::t3ai {
    struct T3AI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<T3AI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T3AI>>(0x2::coin::mint<T3AI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: T3AI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DtYq9vMMUyRJcSJQ6AXPbgGYCbEvWg3nnt5JoZ8FqdMb.png?size=lg&key=9b978c                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<T3AI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"T3AI    ")))), trim_right(b"Trust In Web3 AI                "), trim_right(b"T3 - An AI-Powered Under-Collateralized Lending Protocol--- t3 empowers you to leverage everything and anything, bridging the gap to the $1.4T global lending market by introducing the concept of liquid collateral, secured via intelligent agents on Sui..                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T3AI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T3AI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3AI>>(0x2::coin::mint<T3AI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

