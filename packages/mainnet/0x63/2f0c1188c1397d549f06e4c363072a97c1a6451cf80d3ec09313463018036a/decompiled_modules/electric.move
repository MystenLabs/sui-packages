module 0x632f0c1188c1397d549f06e4c363072a97c1a6451cf80d3ec09313463018036a::electric {
    struct ELECTRIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELECTRIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5d4TPfNw5reKsJikvBu3yhkSKrUJ5HYogsJ9RcjZpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ELECTRIC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ELECTRIC    ")))), trim_right(b"No Electricity                  "), trim_right(x"4e6f20456c656374726963697479202d2024454c4543545249430a0a496d6167696e652061206e6967687420776974686f757420656c6563747269636974792e54686520736b792069732066696c6c656420776974682073746172732c20746865207461626c6520676c6f777320776974682063616e646c656c696768742c20616e64207468652061697220697320616c6976652077697468206c617567687465722e4e4f20454c454354524943495459206272696e6773206261636b2074686f73652073696d706c65206d6f6d656e747320207768657265206c696768742c207761726d74682c20616e6420746f6765746865726e65737320666c6f77206173206e61747572616c6c7920617320746865206e6967687420697473656c662e2020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELECTRIC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELECTRIC>>(v4);
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

