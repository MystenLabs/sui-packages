module 0xab5929946eebb171cf5431a525dec5734115ad5e982f1ce8d3f178158770509e::zoomies {
    struct ZOOMIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOOMIES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"da111c640d5957e4c27daefa637fb6601938c507ab5774147cf4239f0a2c6516                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZOOMIES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Zoomies     ")))), trim_right(b"The Cult of Snoopy              "), trim_right(x"5468652043756c74206f6620536e6f6f70790a4669727374206d656d6520636f696e206261736564206f6e20746865206c696665206f662061204672656e63682042756c6c646f672e0a4265666f7265207468657265207761732061206d6f76656d656e742c20746865726520776173206a75737420536e6f6f707920206120736d616c6c2c2073747562626f726e2c20616e64207269646963756c6f75736c792070686f746f67656e6963204672656e636869652077697468206120706572736f6e616c69747920626967676572207468616e20746865206d6f6f6e202877686963682c20627920746865207761792c20697320776865726520686520706c616e7320746f2074616b652068697320666f6c6c6f77657273292e20426f726e20746f2061207175696574206e65696768626f72686f6f64206c6966652c2053"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOOMIES>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOOMIES>>(v4);
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

