module 0x8e7d62e1e5428d2fefdf0997205125659fcab977aed21ca1da6c328d3c60c4fd::bert {
    struct BERT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BERT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BERT>>(0x2::coin::mint<BERT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BERT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HgBRWfYxEfvPhtqkaeymCQtHCrKE46qQ43pKe8HCpump.png?size=lg&key=2e6f18                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BERT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Bert    ")))), trim_right(b"Bertram The Pomeranian          "), trim_right(b"Abandoned by breeders, adopted and crowned by the people of Solana.                                                                                                                                                                                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BERT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BERT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BERT>>(0x2::coin::mint<BERT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

