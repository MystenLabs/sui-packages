module 0x4dfb823ad793d5a05611040914d84a4d0b00bd99f2967d3241ad89e4274b5992::maxtrans {
    struct MAXTRANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXTRANS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A4i44SMVz7Mn9oGqmUMRmHfyxnAcukNy9qde5bTGpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAXTRANS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MAXTRANS    ")))), trim_right(b"Max Trans                       "), trim_right(x"436f72706f72617465205472616e73706172656e6379204465706172746d656e74206f6620456e726f6e0a0a456e726f6e206973206865726520746f206469737275707420746865207472757374206d652065636f6e6f6d792e20546861747320776879207468697320696e697469617469766520697320706f7765726564206279204d41585452414e533a206f757220626f6c6420636f6d6d69746d656e7420746f204d6178696d756d20436f72706f72617465205472616e73706172656e63792e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXTRANS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXTRANS>>(v4);
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

