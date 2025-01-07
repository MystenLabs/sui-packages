module 0x7eb86d0ab08b9ed738031a7128880be26893c1fa30d11b6b51ee399f5601918b::muskimus {
    struct MUSKIMUS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MUSKIMUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MUSKIMUS>>(0x2::coin::mint<MUSKIMUS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MUSKIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FLn5uGse84BS7R5eyN2wCd8agpGyzNBLS233HhUvpump.png?size=lg&key=40fce9                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MUSKIMUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Muskimus")))), trim_right(b"Muskimus Maximus X              "), trim_right(b"Muskimus Maximus X, a digital gladiator who lately joined forces with Kekius Maximus stands defiant in the virtual Colosseum of our time, his armor emblazoned with the symbol of X.                                                                                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSKIMUS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MUSKIMUS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MUSKIMUS>>(0x2::coin::mint<MUSKIMUS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

