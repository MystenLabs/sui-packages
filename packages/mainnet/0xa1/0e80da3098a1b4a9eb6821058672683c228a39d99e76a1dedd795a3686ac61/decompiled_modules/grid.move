module 0xa10e80da3098a1b4a9eb6821058672683c228a39d99e76a1dedd795a3686ac61::grid {
    struct GRID has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GRID>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GRID>>(0x2::coin::mint<GRID>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GRID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x53413227f9d288679fd2df2d6d6e3bfa8ab7bba2.png?size=lg&key=c2347a                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRID>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRID    ")))), trim_right(b"Grid Capital                    "), trim_right(b"Grid Capital is an automated trading project powered by grid bot strategies. Profits are used to scale the fund, buy & burn the $GRID token, and grow the ecosystem.                                                                                                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRID>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRID>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GRID>>(0x2::coin::mint<GRID>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

