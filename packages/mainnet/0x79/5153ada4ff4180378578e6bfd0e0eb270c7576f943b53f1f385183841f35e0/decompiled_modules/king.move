module 0x795153ada4ff4180378578e6bfd0e0eb270c7576f943b53f1f385183841f35e0::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafybeidclvyu5bux7ycbyms5fvov7wiywr3uopfnnxguyydu3p5m4pwt4y                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<KING>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KING    ")))), trim_right(b"KING                            "), trim_right(b"inspired by the wisdom of legendary Persian kings like Cyrus the Great Xerxes and Darius I as well as the epic tales of Ferdowsi Shahnameh                                                                                                                                                                                      "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<KING>>(0x2::coin::mint<KING>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KING>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING>>(v3);
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

