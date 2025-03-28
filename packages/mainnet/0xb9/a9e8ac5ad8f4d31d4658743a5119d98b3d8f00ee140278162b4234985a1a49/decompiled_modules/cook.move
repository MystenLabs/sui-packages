module 0xb9a9e8ac5ad8f4d31d4658743a5119d98b3d8f00ee140278162b4234985a1a49::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DjKEPXyACzurChwgsSbe91zZkoZsqSAt5CbtpM6mpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COOK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"COOK        ")))), trim_right(b"COOK (Tim Cook Apple Inc. CEO)  "), trim_right(x"434f4f4b202854696d20436f6f6b204170706c6520496e632e2043454f292028434f4f4b290a496e737069726564206279204170706c6520496e632e2043454f2054696d20436f6f6b2e2024434f4f4b20697320612066616e2063726561746564206d656d65636f696e206f6e2074686520536f6c616e6120626c6f636b636861696e2e20546869732070726f6a65637420697320707572656c7920666f7220656e7465727461696e6d656e7420616e642066616e20656e676167656d656e742e2054696d20436f6f6b2069732061206c6567656e64617279206c6561646572206f66204170706c6520496e632e20616e64206a6f696e6564204170706c6520696e204d6172636820313939382061732073656e696f72207669636520707265736964656e7420666f7220776f726c6420776964652073616c657320616e6420"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOK>>(v4);
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

