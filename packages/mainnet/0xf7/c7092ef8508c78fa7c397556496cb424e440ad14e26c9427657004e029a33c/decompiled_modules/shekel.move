module 0xf7c7092ef8508c78fa7c397556496cb424e440ad14e26c9427657004e029a33c::shekel {
    struct SHEKEL has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHEKEL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHEKEL>>(0x2::coin::mint<SHEKEL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHEKEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x5f6a682a58854c7fbe228712aeeffccde0008ac0.png?size=lg&key=f54cd4                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHEKEL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SHEKEL  ")))), trim_right(b"Rabbi Schlomo                   "), trim_right(b"Ai Investment Fund Launchpad. Kosher Capital is a DeFAI infra project that allows users to permissionlessly create their own investment fund managed either by themselves or fully managed by an autonomous agent.                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEKEL>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHEKEL>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHEKEL>>(0x2::coin::mint<SHEKEL>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

