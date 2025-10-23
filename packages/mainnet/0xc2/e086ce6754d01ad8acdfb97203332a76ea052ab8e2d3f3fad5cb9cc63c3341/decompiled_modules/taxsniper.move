module 0xc2e086ce6754d01ad8acdfb97203332a76ea052ab8e2d3f3fad5cb9cc63c3341::taxsniper {
    struct TAXSNIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXSNIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"15094c9e9295e63523de41f1f1ddb71d335a878aa08393c0d0e801bb4d7ff18b                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TAXSNIPER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TAXSNIPER   ")))), trim_right(b"TaxSniper                       "), trim_right(x"204c696768746e696e672d6661737420536f6c616e6120736e6970657220626f74207c204275696c7420666f72207461782f7265776172647320746f6b656e73207c204d696e7420736e6970657320204175746f2d736e6970657320205265616c2d74696d6520706f6f6c207363616e6e696e670a0a20494e5354414e5420455845435554494f4e202d204d696e7420736e6970657320696e206d696c6c697365636f6e64730a20424154544c452d544553544544202d204175746f2d736e6970696e672061646170747320746f20616e79206c61756e63680a20505245434953494f4e20544152474554494e47202d205265616c2d74696d6520706f6f6c207363616e6e696e670a205a45524f2048455349544154494f4e202d204d616e75616c20747261646573206174207370656564206f662074686f756768740a2046"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXSNIPER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAXSNIPER>>(v4);
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

