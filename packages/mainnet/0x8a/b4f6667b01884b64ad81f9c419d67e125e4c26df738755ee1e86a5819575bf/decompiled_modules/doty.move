module 0x8ab4f6667b01884b64ad81f9c419d67e125e4c26df738755ee1e86a5819575bf::doty {
    struct DOTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A4SZ9tfxN2thoks3Ut6U6M1cU5ivDkjSnmqRLr7qpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOTY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOTY        ")))), trim_right(b"DOGGO PARTY                     "), trim_right(x"24444f5459206973206e6f74206a7573742061206d656d65636f696e212053656c65637420796f7572206265742c20616e6420706c617920616761696e7374206f7468657220686f6c646572732120596f752063616e20706172746963697061746520696e20746865206c6561646572626f61726420746f2077696e206d6f72652024444f5459207765656b6c7921200a0a20426574206f6e206f7572206d696e692074656c656772616d20617070212040646f67676f5f70617274795f626f7420282b31376b20557365727329202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOTY>>(v4);
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

