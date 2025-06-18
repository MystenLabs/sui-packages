module 0x85075f722ece6ae316f3a8e293b7eda20e581f84985aa2474c9720e536dc174::convo {
    struct CONVO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CONVO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONVO>>(0x2::coin::mint<CONVO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CONVO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0xab964f7b7b6391bd6c4e8512ef00d01f255d9c0d.png?size=lg&key=148e7a                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CONVO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CONVO   ")))), trim_right(b"Prefrontal Cortex Convo Agent   "), trim_right(b"The Prefrontal Cortex Convo agent is an advanced AI system built for meaningful, dynamic conversations. It integrates perception, long-term memory, and decision-making to deliver personalized, context-aware responses.                                                                                                       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONVO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CONVO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CONVO>>(0x2::coin::mint<CONVO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

