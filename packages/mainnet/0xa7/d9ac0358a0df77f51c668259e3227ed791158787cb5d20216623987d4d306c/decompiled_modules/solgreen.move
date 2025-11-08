module 0xa7d9ac0358a0df77f51c668259e3227ed791158787cb5d20216623987d4d306c::solgreen {
    struct SOLGREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLGREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EafezyDVUKibeL2sdcX79sbD8Ccc3JfcQYM2jhVNeX4K.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOLGREEN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SOLGREEN    ")))), trim_right(b"Solana Green                    "), trim_right(x"536f6c616e6120677265656e202020202020202020534f4c475245454e200a0a5468697320436f696e204973204275696c742042792054686520436f6d6d756e6974790a20416e642054686520486f6c6465727320546f676574686572200a77652077696c6c204d616b65205375726520536f6c616e6120477265656e0a204265636f6d6573204f6e65204f662054686520477265617420506c617965727320496e205468652043727970746f2073706163650a204d616b65205375726520596f75204a6f696e205573204f6e205468697320477265656e205370616365736869700a2057652041726520476f696e672054616b65204f7665722054686520576f726c640a204e6f7720497320546865204368616e636520546f204772616220596f757220426167204561726c79202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLGREEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLGREEN>>(v4);
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

