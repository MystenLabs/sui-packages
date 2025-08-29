module 0xfcf66693e49bd83fc741b9e64e448acbfb58e4b52c2b543564c57e1ca0202901::jack {
    struct JACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4aPqaxDWnqS269NxDAdBLjs5sLCEK2PVAE48oLndmoon.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JACK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JACK        ")))), trim_right(b"Jack Spicer                     "), trim_right(x"5468652063727970746f20756e697665727365206c6f766573206120676f6f64206d656d65616e64206e6f7468696e6720656d626f6469657320766972616c2066756e207175697465206c696b65204a61636b0a5370696365722c2074686520626c61636b20616e64207768697465206361742077697468206120636f77626f792068617420616e6420612073636172662c2062656c6f766564206279206d696c6c696f6e73206f6e0a496e7374616772616d2028407370696365726a61636b6a61636b2920616e642054696b546f6b2028407370696365726a61636b292e20244a41434b206973206120636f6d6d756e6974792d64726976656e0a6d656d6520636f696e20626f726e2066726f6d20746865206c6567656e64206f6620746869732069636f6e696320696e7465726e65742066656c696e652c206465736967"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACK>>(v4);
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

