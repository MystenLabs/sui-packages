module 0x20c44f5a9680fe11296598db913e1de44650d278821b1509f4a9e5bd17d5aad7::chewy {
    struct CHEWY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHEWY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHEWY>>(0x2::coin::mint<CHEWY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHEWY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x1d201117fcdd97abb39a68abe3461960d7c8ba09.png?size=lg&key=df6881                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHEWY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHEWY   ")))), trim_right(b"Chewy                           "), trim_right(b"Chewy the bull celebrates those who kept chewing and embraced the spirit of resilience in the crypto community.                                                                                                                                                                                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEWY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHEWY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHEWY>>(0x2::coin::mint<CHEWY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

