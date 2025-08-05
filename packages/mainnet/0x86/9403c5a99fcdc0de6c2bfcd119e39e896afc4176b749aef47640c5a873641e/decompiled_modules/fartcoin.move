module 0x869403c5a99fcdc0de6c2bfcd119e39e896afc4176b749aef47640c5a873641e::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7AgmZKXzghAG7XqFHhxCX6UMDKBX9BSRNCVWHWkcBAGS.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTCOIN    ")))), trim_right(b"AGA                             "), trim_right(x"54686520416d65726963616e2047617374726f656e7465726f6c6f676963616c204173736f63696174696f6e20284147412920686173206120726573656172636820666f756e646174696f6e2061726d20746861742069732061206e6f6e70726f666974206f7267616e697a6174696f6e207468617420696e766573746967617465732067617374726f696e74657374696e616c206865616c7468202873746f6d61636820697373756573292074686174206361757365206578636573736976652066617274696e67207375636820617320697272697461626c6520626f77656c2073796e64726f6d652c20666f6f6420696e746f6c6572616e6365732c20616e64205349424f200a0a46696e616c6c792c20612066617274636f696e2077697468207574696c6974792e2031303025206f6620666565732077696c6c20676f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTCOIN>>(v4);
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

