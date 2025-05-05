module 0xc521fa431d154e46cc2ef95caf6084cfe4d23df533e12d29c7e2dc82ec094e56::commo {
    struct COMMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6261kNCExfQ2EbbzvhZdYpLERTHGjk8MAzM2e3YbVjeZ.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COMMO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Commo       ")))), trim_right(b"Commo                           "), trim_right(x"54686520507572706c65204b6f616c61205265766f6c7574696f6e206f6e20536f6c616e610a434f4d4d4f2069732074686520666972737420536f6c616e61206d656d6520636f696e2063726561746564207468726f7567682074686520636f6c6c61626f726174696f6e206f662068756d616e206372656174697669747920616e6420414920746563686e6f6c6f67792e204974277320616c736f207468652066697273742063727970746f63757272656e637920746f20637265617465206120313a312072656c6174696f6e73686970206265747765656e20746f6b656e7320616e642068756d616e206265696e67732c2077697468206120746f74616c20737570706c7920746861742065786163746c79206d6174636865732074686520776f726c6420706f70756c6174696f6e206173206f6620446174653a203031"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMMO>>(v4);
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

