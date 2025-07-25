module 0x5d95ada12d24a27cc9d708f4149e5d0cfb206e36ab9ed4cd97becd88537e97f9::omgai {
    struct OMGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8XUKVkSqgMsFQNcMBWQenEVVjcqYa4n2eQbweaML6REV.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OMGAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OMGAI       ")))), trim_right(b"Omega AI                        "), trim_right(x"244f4d4741492e2054686520776f726c642773206d6f7374207265616c697374696320766f6963652041492c20646563656e7472616c697a65642e200a0a486f6c6465727320726577617264656420776974682061697264726f7073206576657279203135206d696e757465732e0a0a546f6b656e6f6d6963733a0a0a20313025206f6620737570706c79206973206c6f636b656420666f7220736563757269747920616e642073746162696c6974792e0a0a20352520746178206f6e206576657279206275792c2073656c6c20616e64207472616e736665722e0a0a20353525206f662074617820726576656e756520646973747269627574656420746f20686f6c6465727320696e204f6d656761205061792028245041592920746f6b656e732e0a0a2034302520697320616c6c6f636174656420746f20646576656c6f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMGAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMGAI>>(v4);
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

