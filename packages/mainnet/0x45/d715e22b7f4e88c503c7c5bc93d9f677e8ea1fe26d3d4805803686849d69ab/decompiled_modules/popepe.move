module 0x45d715e22b7f4e88c503c7c5bc93d9f677e8ea1fe26d3d4805803686849d69ab::popepe {
    struct POPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xa7c981f79d490c0b1f3120589671dc8caacbb9ab720aa383351c54f451071d3c::popepe::popepe.png?size=lg&key=1180b8                                                                                                                                                                         ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<POPEPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POPEPE  ")))), trim_right(b"Popeye Pepe                     "), trim_right(b"Embark on an adventurous journey with Popeye Pepe the latest token to set sail on the Sui blockchain. Symbolized by POPEPE, this token promises to navigate through the waves of the digital economy with the spirit of a fearless captain.                                                                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEPE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPEPE>>(v4);
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

