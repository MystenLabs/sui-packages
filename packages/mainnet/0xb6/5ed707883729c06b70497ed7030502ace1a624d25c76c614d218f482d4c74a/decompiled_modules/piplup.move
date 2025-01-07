module 0xb65ed707883729c06b70497ed7030502ace1a624d25c76c614d218f482d4c74a::piplup {
    struct PIPLUP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIPLUP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PIPLUP>>(0x2::coin::mint<PIPLUP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PIPLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FLASAb39wRP6Q8StBcEnxu48xjUtoQc5zSxAFdu3pump.png?size=lg&key=57e0c6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PIPLUP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PIPLUP  ")))), trim_right(b"Piplup                          "), trim_right(b"Hi, future bestie! Im Piplup the cutest, coolest penguin Pokmon from the Sinnoh region. Sure, Im a water-type wonder, but Im also your champion waddler and ultimate adventure buddy.                                                                                                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPLUP>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIPLUP>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PIPLUP>>(0x2::coin::mint<PIPLUP>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

