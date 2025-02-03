module 0xa8534fd2209c73ac984f2ad339aaf521baea2053a840a69e3307b154ceeba1c4::blm {
    struct BLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/J9HZcdDnMC9TvBqjsCMe7YJyJkX1RX4mBZoefayRPNao.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BLM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BLM         ")))), trim_right(b"George Floyd                    "), trim_right(x"22492043414e2754204252454154484521220a0a496e206d656d6f7279206f662047656f72676520466c6f79642c20776520686f6e6f7220686973206c656761637920616e642074686520636f756e746c65737320766f696365732064656d616e64696e67206a7573746963652e20426c61636b20486973746f7279204d6f6e7468206973206e6f74206a75737420612074696d6520746f207265666c6563742062757420612063616c6c20746f20616374696f6e616e20757267656e742072656d696e64657220746f2075706c6966742c20656d706f7765722c20616e6420666967687420666f7220657175616c6974792e0a0a536179207468656972206e616d65732e2052656d656d6265722074686569722073746f726965732e204b6565702070757368696e6720666f72776172642e2023426c61636b486973746f72"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLM>>(v4);
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

