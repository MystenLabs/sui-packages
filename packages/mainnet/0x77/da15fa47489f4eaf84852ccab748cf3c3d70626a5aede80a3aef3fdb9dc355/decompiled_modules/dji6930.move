module 0x77da15fa47489f4eaf84852ccab748cf3c3d70626a5aede80a3aef3fdb9dc355::dji6930 {
    struct DJI6930 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DJI6930>, arg1: 0x2::coin::Coin<DJI6930>) {
        0x2::coin::burn<DJI6930>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<DJI6930>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DJI6930>(arg0, arg1, arg2, arg3);
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DJI6930>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DJI6930>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DJI6930, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DQnkBM4eYYMnVE8Qy2K3BB7uts1fh2EwBVktEz6jpump.png?size=lg&key=065050                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<DJI6930>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DJI6930   ")))), trim_right(b"DOWGE                           "), trim_right(b"                                                                                                                                                                                                                                                                                                                                "), v2, false, arg1);
        let v6 = v3;
        let v7 = &mut v6;
        let v8 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v7, 1000000000000000000, v8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJI6930>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DJI6930>>(v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DJI6930>>(v4, 0x2::tx_context::sender(arg1));
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

