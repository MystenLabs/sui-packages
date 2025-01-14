module 0x889366359c2a7cac9fb8bd1a3af61c26164d24c2a6b64c3a23e3bd8909063269::orcai {
    struct ORCAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ORCAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ORCAI>>(0x2::coin::mint<ORCAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ORCAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3QW2BMZnsACEjjtxbbv7f5bdSy2ByYCv2rp5dPVWpump.png?size=lg&key=590273                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ORCAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ORCAI   ")))), trim_right(b"Orca AI                         "), trim_right(b"Orca Ai is a cutting-edge solution that empowers traders to create and deploy custom AI agentsall wrapped in a prompt-based interface for truly autonomous trading.                                                                                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORCAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ORCAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ORCAI>>(0x2::coin::mint<ORCAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

