module 0x797e91f5e10e6860f0d93dd5f458353624184cd91c2340e62a85b8b46e83fd65::pythia {
    struct PYTHIA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PYTHIA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PYTHIA>>(0x2::coin::mint<PYTHIA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PYTHIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9RSEqY579nR1eWpBH5uCyXrcy7FDfX8fSC6ctm6upump.png?size=lg&key=d104b3                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PYTHIA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Pythia  ")))), trim_right(b"the world's first Cyber-Rodent  "), trim_right(b"Russian scientists have become the first in the world to connect a rat's brain to artificial intelligence that suggests the right answers to any question.                                                                                                                                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PYTHIA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PYTHIA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PYTHIA>>(0x2::coin::mint<PYTHIA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

