module 0xf3014a2b6b7583eb42b13f3ca04dc78ad738f897f725bed6362ffafef8d3009b::error404a {
    struct ERROR404A has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERROR404A, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/52W1Uia49JYpXmYfwgfZXaEkDrJixynfSnaURDRMbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ERROR404A>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ERROR404    ")))), trim_right(b"ERROR404                        "), trim_right(x"204552524f52203430343a20474c4954434820444558200a0a497473206e6f7420737570706f73656420746f20626520686572652e0a4e6f20646f6373202e204e6f20726f61646d6170202e204e6f207065726d697373696f6e202e204a7573742070757265206f6e2d636861696e206368616f73202e0a0a54726164657320676f207468726f756768202e20546f6b656e7320617070656172202e20436f6e7472616374732076616e697368202e0a4e6f2066726f6e74656e643f20596f752066696e64206f6e65202e204e6f20737570706f72743f20596f7520646f6e74206e656564206974202e0a0a546869732069736e7420612073616665206265742020206974732061206c65616b20696e207468652073797374656d202e0a496620796f752077616e7420706f6c697368656420554920616e642068616e642d68"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERROR404A>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERROR404A>>(v4);
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

