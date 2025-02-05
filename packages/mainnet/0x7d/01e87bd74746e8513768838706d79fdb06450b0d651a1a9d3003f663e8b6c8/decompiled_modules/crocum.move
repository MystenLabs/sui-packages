module 0x7d01e87bd74746e8513768838706d79fdb06450b0d651a1a9d3003f663e8b6c8::crocum {
    struct CROCUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"qagze53X87VEby2X                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CROCUM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CROCUM      ")))), trim_right(b"Crypto.cum                      "), trim_right(x"57656c636f6d6520746f202443524f43554d2c207468652063727970746f20636f696e20746861742773207377696d6d696e6720696e746f20796f75722077616c6c6574207769746820612073706c617368206f662068756d6f722e2e2e616e642073656d656e2e0d0a0d0a496e7370697265642062792074686520736572696f7573207669626573206f662063727970746f2e636f6d2c207765277665206465636964656420746f2074616b65206120646966666572656e7420617070726f61636820206f6e652074686174277320706c617966756c20616e6420612062697420636865656b792e2041742043727970746f2e63756d2c2077652062656c69657665207468617420796f757220696e766573746d656e74206a6f75726e65792073686f756c642062652061732066756e206173206974206973207269736b79"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCUM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCUM>>(v4);
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

