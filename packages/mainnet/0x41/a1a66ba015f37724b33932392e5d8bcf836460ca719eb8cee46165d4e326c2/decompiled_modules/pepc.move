module 0x41a1a66ba015f37724b33932392e5d8bcf836460ca719eb8cee46165d4e326c2::pepc {
    struct PEPC has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPC>>(0x2::coin::mint<PEPC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x7ee83b7d413e0cef103c6235d5ec26099e0d3432.png?size=lg&key=57517e                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPC    ")))), trim_right(b"Pepe Cult                       "), trim_right(b"As the cult of Pepe spreads like a virus, society crumbles under the weight of its self-evolving worship of $PEPE. Believers hold that the truth of memes will manifest in the market, and Pepes will shall dominate the world in the form of economic power.                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPC>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPC>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPC>>(0x2::coin::mint<PEPC>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

