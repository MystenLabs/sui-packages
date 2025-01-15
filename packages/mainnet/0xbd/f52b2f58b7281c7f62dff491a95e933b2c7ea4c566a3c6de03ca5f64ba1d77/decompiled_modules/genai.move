module 0xbdf52b2f58b7281c7f62dff491a95e933b2c7ea4c566a3c6de03ca5f64ba1d77::genai {
    struct GENAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GENAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GENAI>>(0x2::coin::mint<GENAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x45d4a1be13d39fd16e6e56c0159148a534a3ee5d.png?size=lg&key=006c5b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GENAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GENAI   ")))), trim_right(b"Genesis AI                      "), trim_right(b"Genesis is redefining the boundaries of blockchain innovation by merging the unparalleled power of AI with the decentralization of Web3.                                                                                                                                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GENAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GENAI>>(0x2::coin::mint<GENAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

