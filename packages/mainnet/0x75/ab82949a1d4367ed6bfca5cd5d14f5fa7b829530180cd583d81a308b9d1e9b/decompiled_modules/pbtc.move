module 0x75ab82949a1d4367ed6bfca5cd5d14f5fa7b829530180cd583d81a308b9d1e9b::pbtc {
    struct PBTC has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PBTC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PBTC>>(0x2::coin::mint<PBTC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HfMbPyDdZH6QMaDDUokjYCkHxzjoGBMpgaUvpLWGbF5p.png?size=lg&key=7612d2                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PBTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PBTC    ")))), trim_right(b"Purple Bitcoin                  "), trim_right(x"57697468206120666978656420737570706c79206f6620314220616e642061206275726e206d656368616e69736d20746f2064726976652076616c75652c20507572706c652042544320726570726573656e74732053756973206675747572652e205765207374616e6420666f72205375692c20666f7220426974636f696e2c20616e6420666f72207468652070656f706c652e00202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBTC>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PBTC>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PBTC>>(0x2::coin::mint<PBTC>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

