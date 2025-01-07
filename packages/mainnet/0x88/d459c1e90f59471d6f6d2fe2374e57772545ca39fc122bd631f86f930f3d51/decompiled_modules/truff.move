module 0x88d459c1e90f59471d6f6d2fe2374e57772545ca39fc122bd631f86f930f3d51::truff {
    struct TRUFF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRUFF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUFF>>(0x2::coin::mint<TRUFF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TRUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AJ4WgaM2rqJg51FVatUEL63c9tPrmcQH8f6nvVdjpump.png?size=lg&key=c147e0                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUFF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRUFF   ")))), trim_right(b"Truffle Token                   "), trim_right(x"546865206f6e6c79206d656d6520636f696e20636c6173737920656e6f75676820746f20736e696666206f7574207468652066696e6573742070726f6669747320616e6420636865656b7920656e6f75676820746f206e6f7420676976652061207069677320736e6f75742061626f757420616e796f6e6520656c73652e205468652054727566666c65205069672c2069736e7420796f75722061766572616765207377696e65697473206120686967682d636c61737320736e6966666572206f6e2061206d697373696f6e20746f20756e636f76657220726172652074727566666c65732028616e6420666174206761696e73292e0020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUFF>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUFF>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUFF>>(0x2::coin::mint<TRUFF>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

