module 0xfe873de87c2027e5442813f29be935666863418b4833474d0caeca0021c0499c::magal {
    struct MAGAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A2ZbCHUEiHgSwFJ9EqgdYrFF255RQpAZP2xEC62fpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAGAL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MAGAL       ")))), trim_right(b"Magallaneer                     "), trim_right(x"20546865207472656173757265206973207265616c2e0a204d6167616c6c616e6565722068617320736574207361696c2e0a204d656d65436f696e20666f72207265616c2074726561737572652068756e746572732e0a205765206275696c74206120322c3030302b207374726f6e672063726577206f6e2058206265666f7265206c61756e6368696e672e0a20466f6c6c6f7720636c7565732e20556e6c6f636b20736563726574732e0a20466f6c6c6f772074686520636c7565732c2066696e64207468652074726561737572652e0a20446f78786564206465762e204e6f2042532e204a75737420746865206d697373696f6e2e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAL>>(v4);
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

