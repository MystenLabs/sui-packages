module 0xd398a6f93f402576db11fb3acc1d590ae3d6e002e45346e4496da3affe450ef3::kamicoin {
    struct KAMICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ouIT4ahhHmoNHjTG                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KAMICOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KamiCoin    ")))), trim_right(b"KamiCoin                        "), trim_right(x"496e74726f647563696e67204b616d69436f696e3a20456d706f776572696e67205368696e746f204865726974616765207468726f75676820426c6f636b636861696e20496e6e6f766174696f6e0d0a0d0a456d6261726b206f6e2061207472616e73666f726d6174697665206a6f75726e65792077697468204b616d69436f696e2c20612070696f6e656572696e672063727970746f63757272656e63792064656469636174656420746f2070726573657276696e6720616e64207265766974616c697a696e67204a6170616e277320736163726564205368696e746f20736872696e65732e20526f6f74656420696e2074686520616e6369656e7420747261646974696f6e73206f66205368696e746f69736d2c20776869636820656d70686173697a6573206861726d6f6e792077697468206e617475726520616e6420"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMICOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMICOIN>>(v4);
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

