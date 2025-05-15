module 0xc161e705879f0670f47c1bc8ed5a8cec4ed421f1ecf289e767019958d69a5c56::lpc {
    struct LPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CSgLJ6wu9AoJGi4TpC31Lr5CCQkZbwkSUTW6REeC5K3J.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LPC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LPC         ")))), trim_right(b"Loopcoin                        "), trim_right(x"4465666c6174696f6e61727920546f6b656e6f6d6963733a0a20302e323525205472616e73616374696f6e204665652020547265617375727920526576656e75650a20547265617375727920526576656e756520204c6f6f70636f696e204275796261636b730a204c6f6f70636f696e204275796261636b7320205765656b6c7920546f6b656e204275726e696e670a205765656b6c7920546f6b656e204275726e696e67202044656372656173656420546f6b656e20537570706c790a2044656372656173656420546f6b656e20537570706c79202053636172636974790a2053636172636974792020506f74656e7469616c2056616c756520496e6372656173652050657220546f6b656e0a0a546861747320746865204c6f6f7021205468617473204c6f6f70636f696e210a0a4164646974696f6e616c204665617475"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LPC>>(v4);
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

