module 0xe6f7fd466a07a11c69384c9e4721cd71d7bacdd827c7fff854c5471fe217b59e::sima {
    struct SIMA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIMA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SIMA>>(0x2::coin::mint<SIMA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x2100009a5320643e619faa2881d738e3ee529ac0.png?size=lg&key=82f4cd                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SIMA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SIMA    ")))), trim_right(b"Sima Eagle                      "), trim_right(b"$SIMA is a token inspired by the iconic American eagle.  More than a coin, it reflects our mission: promoting a healthy lifestyle and supporting traders' prosperity through media.                                                                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SIMA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SIMA>>(0x2::coin::mint<SIMA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

