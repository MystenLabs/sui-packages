module 0x5dd902497d052ecb5a577dd86470672c508c80e68367f1d7533f432ffb7999da::sign {
    struct SIGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6FupkbAC2UvnqFYZp69yJ2S3BYo1Va8V9jTho9wJpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SIGN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SIGN        ")))), trim_right(b"Petition To Hold Till 100M      "), trim_right(x"446561722066656c6c6f772074726164657273206f6e20536f6c616e612c0a0a546865207374617465206f66206f7572206d61726b657420686173206265636f6d6520766963696f75732c20616e64206675656c6564206279207076702e0a0a4974206973206e6f206c6f6e67657220746865206d656d65636f696e206d61726b657420776520776572652072616973656420696e2c20616e6420697420626172656c7920726573656d626c657320746865206d656e74616c69747920616e6420617474697475646520227761676d692220726570726573656e74732e0a0a496e666573746564207769746820696e736964657220706c6179732c20646f776e7269676874207363616d6d6572732c20616e64206576656e20746865206c696b6573206f6620707265736964656e74732065787472616374696e672076616c75"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGN>>(v4);
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

