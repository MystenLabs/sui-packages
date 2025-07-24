module 0x1ec930e83b029b4da59315247ae8bf083031b325606c1103311570e4d0d97733::litter {
    struct LITTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FtFU8qyvZhk1bh8Gk5uAmAYeTRD8QVBF4KhEBC4zNDMh.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LITTER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LITTER      ")))), trim_right(b"Littercoin                      "), trim_right(x"4c6974746572636f696e20284c49545445522920697320746865206d656d65636f696e20626f726e20746f20636c65616e2075702074686520626c6f636b636861696e20206f6e6520666c697020617420612074696d652e0a496e737069726564206279207468652068756d626c65206c69747465722c20706f7765726564206279206d656d65732c20616e642063617272696564206279206120636f6d6d756e697479206f662065636f2d646567656e732c20244c4954544552206973206865726520746f2070726f76652074686174206576656e2074686520736d616c6c65737420636f696e2063616e206d616b6520612062696720696d706163742e0a466c697020726573706f6e7369626c792e204d656d65207375737461696e61626c792e2020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITTER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LITTER>>(v4);
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

