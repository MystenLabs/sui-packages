module 0x1c793bccc4747946d95a71efb3414062befca91b741a6429375262056b892821::suila {
    struct SUILA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmP82De2rFmvna1WfrYvhwnmxYf8zENsRzpk6Ego8QuffJ                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUILA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SUILA   ")))), trim_right(b"SUILANA                         "), trim_right(x"5375696c616e612028245355494c41292069732074686520517565656e206f66207468652053554920636861696e2e2053686520667573657320534f4c2773206d656d65206368616f73207769746820535549277320736c69636b20656e67696e656572696e672e204120636f6d6d756e6974792d64726976656e20746f6b656e20776974682061206d61737369766520666f7265766572206c697175696469747920706f6f6c20666f7220756e7368616b61626c652074727573742e200a0a4e6f2070616964207368696c6c732c206e6f20726f61646d61702c206a7573742053554920636f6d6d756e69747920766962657320776974682064617920312064656570206c69717569646974792e200a0a466f72207468652063756c747572653a205355494c414e412c2074686520517565656e206f662053554920202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILA>>(v4);
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

