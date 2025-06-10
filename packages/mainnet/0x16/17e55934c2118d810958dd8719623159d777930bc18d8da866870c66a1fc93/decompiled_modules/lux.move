module 0x1617e55934c2118d810958dd8719623159d777930bc18d8da866870c66a1fc93::lux {
    struct LUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BmXfbamFqrBzrqihr9hbSmEsfQUXMVaqshAjgvZupump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LUX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LUX         ")))), trim_right(b"Lux Token                       "), trim_right(x"546865204d756c7469706c6179657220496e7465726e65740a0a4c5558207475726e7320616e79207765627369746520696e746f2061207368617265642c207265616c2d74696d6520657870657269656e63652020776974682070617274792062726f7773696e672c20696e7374616e74207472616e73616374696f6e732c2070726f78696d69747920766f69636520636861742c2073796e63656420766964656f2c20617661746172732c20616e64206d6f72652e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUX>>(v4);
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

