module 0x796cde00fb92e6e1ff6c92ce2f80a5e4dee76dccb37c5e4f07cb579126534630::grump {
    struct GRUMP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GRUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GRUMP>>(0x2::coin::mint<GRUMP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DWcqiU5w58E6jZyABF7QVAVdYWLXjXTJAqk2k1Japump.png?size=lg&key=0a6699                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRUMP   ")))), trim_right(b"Donald Grump                    "), trim_right(b"Since the 1980s, 'Sesame Street' has featured a few greedy, grouchy characters who have been named Donald Grump after Donald Trump                                                                                                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRUMP>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRUMP>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GRUMP>>(0x2::coin::mint<GRUMP>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

