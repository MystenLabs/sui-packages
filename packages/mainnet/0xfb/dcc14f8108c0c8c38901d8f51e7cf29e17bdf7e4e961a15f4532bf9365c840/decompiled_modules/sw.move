module 0xfbdcc14f8108c0c8c38901d8f51e7cf29e17bdf7e4e961a15f4532bf9365c840::sw {
    struct SW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8b700f47b8f7ddae419cd828f2559f37869c2a435b003c938c58b81153a019b3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SW>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SW          ")))), trim_right(b"Wrapped Spotify                 "), trim_right(x"546865206d6f73742d706c61796564207468697320796561723f20596f75206c6f6c20206f6276696f75736c792120437279696e67206f76657220636861727473206174203320412e4d2e200a0a49747320746861742074696d65206f662079656172207768656e2053706f7469667920726f6173747320796f7572206d757369632074617374652d20736f20776520666967757265642c20776879206e6f7420726f61737420796f757220706f7274666f6c696f20746f6f3f20204a6f696e206d696c6c696f6e73206f662053706f74696679206c6f7665727320616e6420646567656e7320666f722074686520756c74696d61746520432e542e4f2e206e6f626f64792061736b656420666f722e200a0a507265737320706c617920746f20756e77726170206f7220636f70652072617468657221202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SW>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SW>>(v4);
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

