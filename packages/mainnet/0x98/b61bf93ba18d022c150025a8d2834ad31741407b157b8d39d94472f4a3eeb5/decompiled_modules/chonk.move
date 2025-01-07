module 0x98b61bf93ba18d022c150025a8d2834ad31741407b157b8d39d94472f4a3eeb5::chonk {
    struct CHONK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHONK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHONK>>(0x2::coin::mint<CHONK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHONK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9tcChCm93yuM93GDiwnERZQrD7wgyU21pHPRFmnxpump.png?size=lg&key=2b4eb6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHONK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHONK   ")))), trim_right(b"Chonk the Frog by Whitaswhit    "), trim_right(b"The official Chonk the Frog coin created by Whitaswhit! Verifiably the only official coin                                                                                                                                                                                                                                       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHONK>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHONK>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHONK>>(0x2::coin::mint<CHONK>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

