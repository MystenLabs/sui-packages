module 0x937c1418c279e67c715a2ce800e0a11952722fda0771ebda983f162bea03562a::ysbiiaa {
    struct YSBIIAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSBIIAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"_1pCXYdrjMCN-fyp                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YSBIIAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YSBII       ")))), trim_right(b"You son of a bitch              "), trim_right(x"202459534249492020544845204d454d4520434f494e20594f552043414e54204d49535321200d0a0d0a496e737069726564206279205269636b20616e64204d6f7274792c20204e6f2070726573616c652c206e6f207465616d20616c6c6f636174696f6e20206a75737420612066616972206c61756e636820616e64207075726520646567656e20656e65726779210d0a0d0a446f6e2774206265206c6174656a6f696e2074686520636f6d6d756e697479206e6f77210d0a2068747470733a2f2f742e6d652f79736269696d6f7274792020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YSBIIAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YSBIIAA>>(v4);
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

