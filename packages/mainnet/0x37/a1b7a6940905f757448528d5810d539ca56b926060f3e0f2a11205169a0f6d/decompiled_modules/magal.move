module 0x37a1b7a6940905f757448528d5810d539ca56b926060f3e0f2a11205169a0f6d::magal {
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
        let (v3, v4) = 0x2::coin::create_currency<MAGAL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MAGAL       ")))), trim_right(b"Magallaneer                     "), trim_right(x"20244d4147414c206973206c6976652e205468652068756e742068617320626567756e2e0a204d656d65436f696e20666f72207265616c2074726561737572652068756e746572732e0a204c6f636b656420737570706c792e20446f78786564206465762e204e6f2042532e0a204d61726b6574696e6720626f6f7374206b69636b73206f6666206561726c79204a756c7920323032352e0a204974206d6179206578706c6f646520776974686f7574207761726e696e672e0a20414920636f6e74656e742e20506972617465206c6f72652e2046756c6c2073746f7279206d6f64652e0a2047657420696e206561726c79206f7220676574206c65667420626568696e642e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
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

