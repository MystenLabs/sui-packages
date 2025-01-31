module 0x255a343906aad904a6d43fbe5ba07b08b8e26aa04e370f00d54c9e294ea450e0::kikin {
    struct KIKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GLNKGX5b5vWmjbNqEoMKSXqRuwW2yayL3ENiBVjoqEsF.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KIKIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KIKIN       ")))), trim_right(b"Kikincoin                       "), trim_right(x"4b696b696e206973207468652066697273742043727970746f2054727573742046756e64204261627920696e2074686520776f726c642e200a4865277320726963682062656361757365206869732064616420626f7567687420444f474520302e33207365636f6e647320616674657220697420776173206c61756e636865642c206865206469646e2774206576656e2072656164207468652077686974652070617065722c20746f74616c2063686164206d6f76652e0a0a4e6f77204b696b696e206973206f6e2061206d697373696f6e20746f20626520746865206e65787420646f676520616e64206d616b6520616c6c20746865206b69647320696e2074686520776f726c6420726963682e2048652062656c6965766573206b6964732073686f756c64206e6f7420626520706f6f7220616e64207468617420746865"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIKIN>>(v4);
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

