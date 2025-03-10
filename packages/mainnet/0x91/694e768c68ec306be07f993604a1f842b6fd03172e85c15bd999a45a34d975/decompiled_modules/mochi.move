module 0x91694e768c68ec306be07f993604a1f842b6fd03172e85c15bd999a45a34d975::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCHI>>(0x2::coin::mint<MOCHI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0xf6e932ca12afa26665dc4dde7e27be02a7c02e50.png?size=lg&key=92d1fd                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOCHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOCHI   ")))), trim_right(b"Mochi                           "), trim_right(b"Mochi is Sui Chain's favourite feline! Named after the CEO of Coinbase's pet cat, this cute orange fur-ball is a first mover on Coinbase's chain and supported by a Coinbase grant! Hundreds of millions of users are coming onchain through Sui; Mochi is ready to greet the masses.                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCHI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOCHI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCHI>>(0x2::coin::mint<MOCHI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

