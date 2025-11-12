module 0x102d72ae6efedb7602482394e6880981464835ef0e9898a36ce0b637b5f3ac6f::raydium {
    struct RAYDIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAYDIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"edb8ac09a396ff1d9109f1824f7bb91bcbc5ecff5599495382f3a7e92e501e85                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RAYDIUM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RAYDIUM     ")))), trim_right(b"RAYDIUM                         "), trim_right(x"5261796469756d20706f7765726564206279206c61756e636870616420616e64206669727374205261796469756d206f6e2074686520706c6174666f726d2077656e646f7464657620706c6174666f726d20746869732063616e206265206875676520616c736f206669727374205261796469756d20636f696e20746f6b656e697a65640a0a4c696b6520426f6e6b66756e20616e642070756d7066756e2068656176656e20706c6174666f726d2061726520706f7765726564206279206d657465726f0a576865726561730a57656e646f7464657620697320706f7765726564206279205261796469756d200a31737420706c6174666f726d20737570706f727465642066726f6d205261796469756d20616e64206261636b6564206279207468656d200a0a5468697320706c6174666f726d20616c736f20676976657320"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAYDIUM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAYDIUM>>(v4);
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

