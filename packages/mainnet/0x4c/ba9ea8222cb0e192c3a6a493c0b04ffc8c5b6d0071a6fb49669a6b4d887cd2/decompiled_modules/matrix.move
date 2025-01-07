module 0x4cba9ea8222cb0e192c3a6a493c0b04ffc8c5b6d0071a6fb49669a6b4d887cd2::matrix {
    struct MATRIX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MATRIX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MATRIX>>(0x2::coin::mint<MATRIX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MATRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x362033a25b37603d4c99442501fa7b2852ddb435.png?size=lg&key=267dcc                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MATRIX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MATRIX  ")))), trim_right(b"MATRIX                          "), trim_right(b"Elon Musk, a visionary entrepreneur and technological maverick, has long been at the forefront of innovation.The concept of the MATRIX, popularized by science fiction, refers to a virtual world that simulates reality, blurring the boundaries between what is real and what is simulated.                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATRIX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MATRIX>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MATRIX>>(0x2::coin::mint<MATRIX>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

