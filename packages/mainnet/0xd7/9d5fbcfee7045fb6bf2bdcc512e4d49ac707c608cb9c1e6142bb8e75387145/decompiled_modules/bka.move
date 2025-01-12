module 0xd79d5fbcfee7045fb6bf2bdcc512e4d49ac707c608cb9c1e6142bb8e75387145::bka {
    struct BKA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BKA>>(0x2::coin::mint<BKA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x2dbcf653377ac85ef05fbfb415224a8d2aaec33d.png?size=lg&key=4d1898                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BKA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BKA     ")))), trim_right(b"Beaker AI                       "), trim_right(b"Beaker AI is a DeFi R&D laboratory that focuses on generation of smart and real yield for users. We aim to simplify the complexity of DeFi by creating the best opportunities and maximizing returns for every user through.                                                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BKA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BKA>>(0x2::coin::mint<BKA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

