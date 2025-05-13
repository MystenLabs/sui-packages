module 0x3a897a089a6b893b440b201305ad75b47ec4b25475157aabe2543e82c4f844d1::bpay {
    struct BPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9aLzSdra8iP4xdvKKnErFxzWwe3R7groGaeGgsb5jREV.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BPAY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BPAY        ")))), trim_right(b"ButtPay                         "), trim_right(x"24427574747061797920697320612072657761726420746f6b656e2074686174207061797320796f75206f757420696e202442757474686f6c652e0a0a313025205472616e73616374696f6e20666565206f6e206576657279207472616e73616374696f6e207768696368206973207468656e207573656420746f206275726e2c20616e642072657761726420686f6c6465727320696e202442757474686f6c652e2045766572796f6e652077696e73206e6f206d617474657220776861742e0a0a52656d656d6265722c20796f752063616e74206661727420776974686f757420612042757474686f6c652e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPAY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPAY>>(v4);
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

