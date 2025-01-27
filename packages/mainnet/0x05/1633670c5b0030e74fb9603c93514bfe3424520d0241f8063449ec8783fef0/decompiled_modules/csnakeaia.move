module 0x51633670c5b0030e74fb9603c93514bfe3424520d0241f8063449ec8783fef0::csnakeaia {
    struct CSNAKEAIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSNAKEAIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CwJk7KK9CaoJtHdyetp41anUxLJKutCkStVidwzgpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CSNAKEAIA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CSNAKEAI    ")))), trim_right(b"Chinese zodiac's Snake          "), trim_right(x"4368696e657365207a6f64696163277320536e616b652c2073796d626f6c697a696e6720776973646f6d20616e6420666f7274756e652c20244368696e65736520536e616b6520636f696e2061696d7320746f2063726561746520612070726f737065726f75732063727970746f20636f6d6d756e697479207468726f756768207374726174656769632066656174757265732c20756e6971756520746f6b656e6f6d6963732c20616e642070726163746963616c207574696c6974792c20676f696e67206265796f6e64206d6572652073796d626f6c69736d20746f206f66666572206c6f6e672d7465726d2076616c756520616e6420656e676167656d656e742e0a0a2043413a2043774a6b374b4b3943616f4a744864796574703431616e55784c4a4b7574436b5374566964777a6770756d7020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSNAKEAIA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSNAKEAIA>>(v4);
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

