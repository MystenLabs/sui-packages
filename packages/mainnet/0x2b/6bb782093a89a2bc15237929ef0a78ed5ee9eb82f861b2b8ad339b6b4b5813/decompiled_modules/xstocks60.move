module 0x2b6bb782093a89a2bc15237929ef0a78ed5ee9eb82f861b2b8ad339b6b4b5813::xstocks60 {
    struct XSTOCKS60 has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSTOCKS60, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6viXzTDHRQPnniZ7aZmmGzunWvT2w2RHr69nGnMnpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XSTOCKS60>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XSTOCKS60   ")))), trim_right(b"XSTOCKS60                       "), trim_right(x"585453544f434b36300a57616c6c205374726565742072696e67732062656c6c732e205765207472616465206f6e2d636861696e2e0a3630206f6620746865206269676765737420552e532e2073746f636b7320284170706c652c205465736c612c204e76696469612c2047616d6553746f702e2e2e20796f75206e616d6520697429206e6f77206c6976652061732053504c20746f6b656e73206f6e20536f6c616e612e2046756c6c79206261636b656420313a312e0a4b72616b656e2062726f756768742073746f636b7320746f20536f6c616e612e20585453544f434b3630206272696e6773207468652070756d7020746f2050756d7066756e2e0a5472616461626c652c204d656d6561626c652c20556e73746f707061626c652e0a546869732069736e7420434e4243206974732043542e20202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSTOCKS60>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XSTOCKS60>>(v4);
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

