module 0x739cd2ccd717717bd1f58c1238c5f028b9cb62b2615551d8f7734046b5ba7d66::skybrise {
    struct SKYBRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYBRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A2z5wm4i6aPvi2NkrfQFah5CADvQp8miTx1eKtVepump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SKYBRISE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SKYBRISE    ")))), trim_right(b"Skybrise                        "), trim_right(x"556e6c6f636b2074686520506f776572206f66205365616d6c6573732044617461204d616e6167656d656e74207769746820536b7962726973650a0a417420536b7962726973652c207765207265766f6c7574696f6e697a6520686f7720627573696e6573736573206d616e61676520646174612e204f757220636c6f756420736f6c7574696f6e732073696d706c6966792073746f726167652c206d616e6167656d656e742c20616e642073656375726974792c206f66666572696e6720666c657869626c6520616e64207363616c61626c65206f7074696f6e7320666f7220616e7920627573696e6573732c2066726f6d20737461727475707320746f20656e7465727072697365732e0a0a556e6c6f636b20746865206e657874206c6576656c206f662064617461206d616e6167656d656e7420776974682041492d70"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYBRISE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKYBRISE>>(v4);
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

