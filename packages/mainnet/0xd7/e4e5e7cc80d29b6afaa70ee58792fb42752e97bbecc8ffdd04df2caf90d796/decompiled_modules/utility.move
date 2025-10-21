module 0xd7e4e5e7cc80d29b6afaa70ee58792fb42752e97bbecc8ffdd04df2caf90d796::utility {
    struct UTILITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTILITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"86f1fb044e35913813223196d2141da96f25d5549ae4afbb3054a863dca7a6cc                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<UTILITY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"UTILITY     ")))), trim_right(b"Utility Coin                    "), trim_right(x"57687920736574746c6520666f72206f6e65207574696c697479207768656e20796f752063616e2068617665207468656d20616c6c3f0a0a546865205573656c65737320436f696e204b696c6c65722e0a0a22616d617a696e672070726f64756374732077697468207265616c207574696c697479203d20496e7465726e6574204361706974616c204d61726b65747322202d20546f6c79202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTILITY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UTILITY>>(v4);
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

