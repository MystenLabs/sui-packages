module 0x7ff36999fc66e0d55cebe489c126d86cc3f28d5d20c91aff1a0f1d93957dfd00::venko {
    struct VENKO has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<VENKO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<VENKO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: VENKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3xhezws6Lk7cMqoVEfZFXu3ry9GKymFz1vbWyQ4f99uX.png?size=lg&key=485b97                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<VENKO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VENKO   ")))), trim_right(b"VENKO                           "), trim_right(b"This friendly alien loves to make new friends and to abduct cute cuddly pets, and captivated by the marvels of the SUI blockchain, and holding immense respect for Anatoly Yakovenko, this friendly alien decided to abduct Anatoly's last five letters.                                                                        "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VENKO>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VENKO>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<VENKO>>(0x2::coin::mint<VENKO>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<VENKO>>(v4, 0x2::tx_context::sender(arg1));
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

