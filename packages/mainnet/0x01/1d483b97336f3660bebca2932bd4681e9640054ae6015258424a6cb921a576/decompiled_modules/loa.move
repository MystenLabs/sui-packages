module 0x11d483b97336f3660bebca2932bd4681e9640054ae6015258424a6cb921a576::loa {
    struct LOA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOA>>(0x2::coin::mint<LOA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LOA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9RAghejZNirG4skdqUXxVVSnKGmYSjjjgnPMPjyJmoon.png?size=lg&key=c9925b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LOA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LOA     ")))), trim_right(b"The Law Of Attraction           "), trim_right(b"Brought to you from the team that created the most successful Law of Attraction project in crypto, this $LOA re-launch was born in response to the universe conspiring to create a unique set of circumstances.                                                                                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LOA>>(0x2::coin::mint<LOA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

