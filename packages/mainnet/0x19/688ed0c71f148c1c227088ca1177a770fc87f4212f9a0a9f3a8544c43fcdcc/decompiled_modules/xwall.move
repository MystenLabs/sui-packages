module 0x19688ed0c71f148c1c227088ca1177a770fc87f4212f9a0a9f3a8544c43fcdcc::xwall {
    struct XWALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: XWALL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/bafkreig7ckqw7e7ikcgkghidnktzvu3srxnd4fteasm2depmix2lhjs35y                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XWALL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XWALL   ")))), trim_right(b"X WALLET                        "), trim_right(x"5b582057414c4c45545d20544f4b454e2f434f494e204d41444520494e20414d45524943412c20464f5220414d45524943414e532e200a4c4f434b20494e2056414c554520544f444159210a205649534954205857414c4c45542e535041434520464f522056414c554520414e4420494e464f524d4154494f4e204f4e205448495320582057414c4c455420434f494e2f544f4b454e2120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XWALL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XWALL>>(v4);
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

