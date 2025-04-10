module 0x81659670a280b4e9176845cffe0e81163b223607f12b00b25eaf2ae7e863887e::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAGA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGA>>(0x2::coin::mint<MAGA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x717eb43f74c8eefdf4f61af6f32005261470a0d0.png?size=lg&key=acaa3e                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAGA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MAGA    ")))), trim_right(b"Make America Green Again        "), trim_right(b"Following the tarrif news, Make America Green Again is zooming in like a neon-green rocket ship after the markets latest pump-tastic explosion! Wall Streets popping off like a fireworks finale, moneys piling up greener.                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAGA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGA>>(0x2::coin::mint<MAGA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

