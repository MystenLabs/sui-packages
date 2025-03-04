module 0x6393b2a0c188f7f225fe4f77ba1d5fe4fe59250fd5e0084b6ac16235ec63abdb::ptsd {
    struct PTSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/APL9pkQRyskX9brwue5Sx1ZesAAgF7mJ7r7bQVepump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PTSD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PTSD        ")))), trim_right(b"Post Trump Solana Disorder      "), trim_right(x"496e74726f647563696e672050545344202074686520636f6d6d756e697479207468617473206865726520746f2067657420726576656e6765206f6e2074686520747261756d6120636175736564206279207468652062696767657374206e616d657320696e207468652067616d6521200a0a5768657468657220697473205472756d702c204d656c616e69612c2074686520417267656e74696e69616e20507265736964656e742c206f722048617964656e2044617669732c2050545344206973206669676874696e67206261636b207769746820612076656e6765616e63652e200a0a4a6f696e20746865206d6f76656d656e742c20686f6c6420746865206c696e652c20616e64207475726e20746865207461626c6573206f6e2074686f73652077686f76652074616b656e2066726f6d207468652063727970746f20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTSD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTSD>>(v4);
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

