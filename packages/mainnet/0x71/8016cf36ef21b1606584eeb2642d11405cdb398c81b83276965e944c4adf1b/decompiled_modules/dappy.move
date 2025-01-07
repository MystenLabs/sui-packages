module 0x718016cf36ef21b1606584eeb2642d11405cdb398c81b83276965e944c4adf1b::dappy {
    struct DAPPY has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DAPPY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DAPPY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xf41fad473e3529d6bc2348378d0ebfdfe8a1c47d.png?size=lg&key=9f8d72                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<DAPPY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DAPPY   ")))), trim_right(b"Dappy                           "), trim_right(b"DAPPY Goblin Pirate Engineer is here to conquer the whales and bring u the Map. Enter and dare to ride with the Horde... Best Memetics & Pampamentals on SUI                                                                                                                                                                    "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAPPY>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DAPPY>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<DAPPY>>(0x2::coin::mint<DAPPY>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DAPPY>>(v4, 0x2::tx_context::sender(arg1));
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

