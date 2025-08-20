module 0x44f68e5e22ebac95581bfa408adf5d04be956f64a09ec78695ee891c9888fc18::tgl {
    struct TGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/969L2FYMBqXTo6Ejs59oM1swNgW5XkBtzG2y5BxmHREV.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TGL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TGL         ")))), trim_right(b"TG Launch                       "), trim_right(x"4372656174652c206c61756e63682c20616e64206561726e2066726f6d20536f6c616e6120746f6b656e73206566666f72746c6573736c79207468726f756768206f75722054656c656772616d20626f742e204a6f696e2074686520667574757265206f6620646563656e7472616c697a656420746f6b656e206372656174696f6e200a0a5768792074686520313025205461783f0a0a4173206120686f6c6465722c20796f752061726520726577617264656420536f6c616e61206576657279203135206d696e757465732c206175746f6d61746963616c6c792061697264726f7070656420746f20796f752e205061737369766520696e636f6d652c206566666f72746c6573736c79206561726e65642062792073696d706c7920686176696e67206f757220746f6b656e20696e20796f75722077616c6c65742e0a0a54"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGL>>(v4);
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

