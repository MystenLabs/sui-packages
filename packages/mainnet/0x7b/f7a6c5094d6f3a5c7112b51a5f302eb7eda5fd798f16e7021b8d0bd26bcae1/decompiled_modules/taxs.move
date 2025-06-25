module 0x7bf7a6c5094d6f3a5c7112b51a5f302eb7eda5fd798f16e7021b8d0bd26bcae1::taxs {
    struct TAXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"7941f66ebd8754675a4bf14a5d10004a660ee4f3e10eaba834e6b1cd83e7f422                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TAXS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TAXS        ")))), trim_right(b"Taxbane                         "), trim_right(x"54415842414e45202054686520416e74692d5461782043727970746f204d6f76656d656e740a0a54415842414e452069732061206d656d652d6675656c656420726562656c6c696f6e20616761696e73742068696464656e20666565732c20737465616c746820696e666c6174696f6e2c20616e64206f757464617465642066696e616e63652e204e6f2074617865732e204e6f2070726573616c652e204e6f20696e7369646572732e204a75737420707572652c206f6e2d636861696e2066697265206261636b656420627920636f6d6d756e69747920706f77657220616e642066616972206c61756e6368206574686963732e0a0a204275696c7420666f722066726565646f6d0a204675656c6564206279206d656d65730a205573656420666f72207265616c2d776f726c642063727970746f207061796d656e74730a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAXS>>(v4);
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

