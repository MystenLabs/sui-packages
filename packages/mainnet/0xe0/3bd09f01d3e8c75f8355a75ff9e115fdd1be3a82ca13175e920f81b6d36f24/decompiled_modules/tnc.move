module 0xe03bd09f01d3e8c75f8355a75ff9e115fdd1be3a82ca13175e920f81b6d36f24::tnc {
    struct TNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FwjTQ2pv7v34LUXmig9ptYWzn5hUnpuyAqdngYmSpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TNC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TNC         ")))), trim_right(b"The Nobody Coin                 "), trim_right(x"5768617420746f20657870656374207769746820546865204e6f626f647920436f696e3f200a5769746820546865204e6f626f647920436f696e2c2077652077616e7420746f2073686f772074686174206e6f742065766572797468696e672069732061626f75742066616d6520616e64206d656d65732e20427574207468617420776974682061207374726f6e6720636f6d6d756e69747920746f67657468657220796f752063616e20637265617465206120737563636573732e200a0a596f752063616e20736565207468697320617320612073746174656d656e7420616761696e737420616c6c20746865206269672063656c656272697479636f696e7320616e6420616761696e737420746865206d656d65636f696e73206f6620776869636820393025206172652072756770756c6c65642e20576520616c736f20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNC>>(v4);
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

