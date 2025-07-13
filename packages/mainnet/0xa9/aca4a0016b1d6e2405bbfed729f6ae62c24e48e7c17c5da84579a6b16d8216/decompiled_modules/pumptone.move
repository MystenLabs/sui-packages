module 0xa9aca4a0016b1d6e2405bbfed729f6ae62c24e48e7c17c5da84579a6b16d8216::pumptone {
    struct PUMPTONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPTONE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DK47D6Xu8dhhuc3DEQXtcDN6pZYN84UH6etTCFzipump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMPTONE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUMPTONE    ")))), trim_right(b"PUMP FUN STONE LIVE             "), trim_right(x"492077696c6c207061696e74206173206d616e792073746f6e657320617320706f737369626c6520696e2050756d7066756e20636f6c6f72732e0a4f6e65206279206f6e652e0a4c6976652e204e6f6e2073746f702e0a42726f616463617374206469726563746c79206f6e207468652050756d7066756e20706c6174666f726d2e0a0a416e64204920776f6e742073746f702e2e2e0a4e6f7420756e74696c20776520726561636820612031304d206d61726b6574206361702e0a0a57687920616d204920646f696e6720746869733f0a4265636175736520492077616e7420746f2063656c65627261746520746865206c61756e6368206f6620746865206f6666696369616c2050554d5046554e20544f4b454e200a6e6f74207769746820776f7264732c20627574207769746820616374696f6e2c20636f6c6f722c20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPTONE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPTONE>>(v4);
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

