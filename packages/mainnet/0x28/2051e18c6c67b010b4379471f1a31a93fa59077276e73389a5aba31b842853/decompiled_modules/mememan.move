module 0x282051e18c6c67b010b4379471f1a31a93fa59077276e73389a5aba31b842853::mememan {
    struct MEMEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7hkaNwNfnDDSwY9i1oWVJYqrFNRnTrWUpkpAaqGntwar.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MEMEMAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MEMEMAN     ")))), trim_right(b"Meme Man                        "), trim_right(x"48692c206d79206e616d65206973204d454d454d414e2e0a0a492077617320626f726e2066726f6d20746865207375727265616c206d656d65206572612020612073796d626f6c206f662073696d706c696369747920616e642072616e646f6d6e6573732e0a0a50656f706c65206b6e6f77206d65206173207468652073746f6e6b73206775792c20627574204d79207265616c206e616d6520696e206d656d652063756c74757265206973204d656d65204d616e2e20526570726573656e74696e67207468652075707320616e6420646f776e73206f66206d61726b65747320616e64206c6966652e200a0a4920737072656164206163726f73732074686520696e7465726e6574206265636175736520496d2072656c617461626c652c2066756e6e792c20616e642074696d656c6573732e0a0a4e6f7720496d206d6f72"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEMAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEMAN>>(v4);
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

