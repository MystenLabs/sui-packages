module 0xae009708f36e498b6d287c7f1a474e995f871dc0b0239473f1a6b402debeb049::zex {
    struct ZEX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZEX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZEX>>(0x2::coin::mint<ZEX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ZEXy1pqteRu3n13kdyh4LwPQknkFk3GzmMYMuNadWPo.png?size=lg&key=3ff72f                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZEX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZEX     ")))), trim_right(b"Zeta                            "), trim_right(b"Zeta Markets is building the fastest, simplest and most secure perps DEX on the market. By leveraging the cutting-edge scalability of Solana, Zeta offers comparable features and performance to a CEX, whilst retaining the self-custodial nature and transparency of a DEX.                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZEX>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZEX>>(0x2::coin::mint<ZEX>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

