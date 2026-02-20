module 0x67a0dcdfc45201d3ac5c5beceffde3bfd1e40aebf0e43f236d512acd2db2fdc2::velvet {
    struct VELVET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VELVET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VELVET>>(0x2::coin::mint<VELVET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VELVET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/848c1701697ba75d14d75e0c72adc0b876c2d2990cd365746f9853e6cd82cc63?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VELVET>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VELVET  ")))), trim_right(b"Velvet                          "), trim_right(b"VELVET is the main token of the Velvet ecosystem, which unlocks utility once staked as veVELVET. veVELVET stakers enjoy: real yield & additional $VELVET rewards, platform fee discounts, increased fee sharing from referrals, voting rights on the major decisions.                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VELVET>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VELVET>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<VELVET>>(0x2::coin::mint<VELVET>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

