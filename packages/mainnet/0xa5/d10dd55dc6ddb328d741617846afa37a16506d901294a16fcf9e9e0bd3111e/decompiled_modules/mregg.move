module 0xa5d10dd55dc6ddb328d741617846afa37a16506d901294a16fcf9e9e0bd3111e::mregg {
    struct MREGG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MREGG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MREGG>>(0x2::coin::mint<MREGG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MREGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/136z1zH6JAKP6UVkgnnT6scxHbezzUFYMjsu4CRVPpAa.png?size=lg&key=0854ce                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MREGG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MrEgg   ")))), trim_right(b"Mr. Eggcellent                  "), trim_right(x"446964204d722e2045676763656c6c656e7420636f6d65206265666f72652074686520636869636b656e3f2054686520776f726c64206d6179206e65766572206b6e6f772e204d72456767206973206865726520746f20736372616d626c652074686520636f6d7065746974696f6e20616e642073657276652075702070726f666974732100202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MREGG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MREGG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MREGG>>(0x2::coin::mint<MREGG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

