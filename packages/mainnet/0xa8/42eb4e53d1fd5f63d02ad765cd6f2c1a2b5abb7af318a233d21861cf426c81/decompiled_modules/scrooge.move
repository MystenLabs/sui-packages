module 0xa842eb4e53d1fd5f63d02ad765cd6f2c1a2b5abb7af318a233d21861cf426c81::scrooge {
    struct SCROOGE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SCROOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SCROOGE>>(0x2::coin::mint<SCROOGE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SCROOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/B9FRYtSikudV9EdHLwKdv3jqhyHgu19pYbuKQDYk6RSk.png?size=lg&key=52a65d                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SCROOGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SCROOGE ")))), trim_right(b"Griffain Agent Scrooge          "), trim_right(b"Griffain Agent Scrooge's first Memecoin!! $Scrooge Follow the Griffain Agent on his way to becoming the Richest AI Agent in the World                                                                                                                                                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCROOGE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SCROOGE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SCROOGE>>(0x2::coin::mint<SCROOGE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

