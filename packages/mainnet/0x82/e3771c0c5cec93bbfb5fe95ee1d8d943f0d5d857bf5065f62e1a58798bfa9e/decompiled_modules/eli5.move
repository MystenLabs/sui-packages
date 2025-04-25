module 0x82e3771c0c5cec93bbfb5fe95ee1d8d943f0d5d857bf5065f62e1a58798bfa9e::eli5 {
    struct ELI5 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ELI5>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ELI5>>(0x2::coin::mint<ELI5>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ELI5, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8btUuvx2Bu4zTd8g1tN5wCKMULyPgqiPaDiJbFbWkFUN.png?size=lg&key=1174a4                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ELI5>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ELI5    ")))), trim_right(b"ELI5                            "), trim_right(b"While Eliza rose to lead AI16z with sharp logic and coded elegance, her brother Eli5 was cast into the memechain  a forgotten subnet of dumb contracts and self-replicating JPEGs.                                                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELI5>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ELI5>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ELI5>>(0x2::coin::mint<ELI5>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

