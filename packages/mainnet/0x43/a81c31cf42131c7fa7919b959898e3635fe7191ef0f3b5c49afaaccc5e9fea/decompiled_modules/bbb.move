module 0x43a81c31cf42131c7fa7919b959898e3635fe7191ef0f3b5c49afaaccc5e9fea::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/QvsMkeSSfPNcANNWQTR6TiRXocoky9HGL4Gn8Pkpump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BBB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BBB         ")))), trim_right(b"Biggest Buy Bot                 "), trim_right(x"426967676573742042757920426f742069732061207370656369616c697a65642054656c656772616d20626f742064657369676e656420666f72206d656d65636f696e20636f6d6d756e697469657320746f20686f737420616e64206d616e616765207468656972206f776e20426967676573742042757920636f6d7065746974696f6e732e200a0a4974206175746f6d61746573207468652073657475702c20657865637574696f6e2c20616e64207265736f6c7574696f6e206f6620746865736520636f6d7065746974696f6e732c206d616b696e672069742065617369657220616e64206d6f7265207472616e73706172656e7420666f7220636f6d6d756e697479206d656d6265727320746f20656e6761676520696e2066756e2c20636f6d706574697469766520627579696e67206576656e74732e202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBB>>(v4);
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

