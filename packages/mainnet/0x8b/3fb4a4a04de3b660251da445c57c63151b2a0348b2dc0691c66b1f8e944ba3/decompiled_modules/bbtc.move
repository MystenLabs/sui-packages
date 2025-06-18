module 0x8b3fb4a4a04de3b660251da445c57c63151b2a0348b2dc0691c66b1f8e944ba3::bbtc {
    struct BBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5HvmxE9M24Z1EPxgyd6vCWeYnDF9bMnQYnfLvE2USMHF.png?claimId=RCtWC1OgvWucdXEg                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BBTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BBTC        ")))), trim_right(b"Black Bitcoin                   "), trim_right(x"426c61636b20426974636f696e20697320746865206e657720626c61636b20676f6c64206f6e2074686520536f6c616e6120626c6f636b636861696e2e2041206e6577206c6567656e64617279207465616d206f66206465646963617465642070726f66657373696f6e616c73207769746820612070726f76656e207265636f726473206973206e6f77206c656164696e6720746869732067726561742070726f6a6563742e0a576974682061206c6f6e677465726d20636f6d6d69746d656e742c207765206172652061696d696e6720746f2074616b6520746869732070726f6a65637420746f20756e696d6167696e61626c65207465727269746f72792e0a506c65617365204a6f696e207468652066616d696c7920616e6420656e6761676520776974682075732e2077652077696c6c206265207769746820796f7520"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBTC>>(v4);
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

