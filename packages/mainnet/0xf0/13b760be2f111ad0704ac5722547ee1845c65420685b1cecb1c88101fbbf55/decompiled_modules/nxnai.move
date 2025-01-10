module 0xf013b760be2f111ad0704ac5722547ee1845c65420685b1cecb1c88101fbbf55::nxnai {
    struct NXNAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NXNAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NXNAI>>(0x2::coin::mint<NXNAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NXNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x2d5fb4daae0e8cc6e39da2e6936fb48f6fcdee2f.png?size=lg&key=b39c02                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NXNAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NXNAI   ")))), trim_right(b"Nexon AI                        "), trim_right(b"Welcome to Nexon AI - Bringing autonomous AI agents to DeFi and DeSci. Nexon enables the creation and deployment of intelligent agents that manage financial operations, trading, data analytics, and governance with minimal human intervention.                                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NXNAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NXNAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NXNAI>>(0x2::coin::mint<NXNAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

