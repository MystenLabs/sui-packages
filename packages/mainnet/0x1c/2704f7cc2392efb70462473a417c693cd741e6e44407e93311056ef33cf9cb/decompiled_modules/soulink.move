module 0x1c2704f7cc2392efb70462473a417c693cd741e6e44407e93311056ef33cf9cb::soulink {
    struct SOULINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOULINK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/LfDNpPIww303OLpKdxUO6TJ3xl2nt4NjrXC3ZtvtNV4";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/LfDNpPIww303OLpKdxUO6TJ3xl2nt4NjrXC3ZtvtNV4"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<SOULINK>(arg0, 4, trim_right(b"SOULINK"), trim_right(b"SOULINK  "), trim_right(x"416761696e737420636f6e74726f6c2073797374656d732e20416761696e73742068617276657374696e672e20416761696e7374206d616e6970756c6174696f6e2e0a4c6574207265616c206e65656473206265207365656e2e204d757475616c2068656c70207265706c61636573207472616e73616374696f6e732c746861742069732076616c75652e0a4e6f206d6f7265206e65656420746f207368726577646c79206578706c6f6974206f7468657273206a75737420746f206765742062792e0a5472757374206265747765656e2070656f706c652063616e2066696e616c6c79207265636f6e6e6563742e"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SOULINK>>(0x2::coin::mint<SOULINK>(&mut v5, 10000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOULINK>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SOULINK>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOULINK>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

