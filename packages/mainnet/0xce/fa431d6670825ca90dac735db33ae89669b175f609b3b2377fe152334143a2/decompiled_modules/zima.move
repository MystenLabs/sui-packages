module 0xcefa431d6670825ca90dac735db33ae89669b175f609b3b2377fe152334143a2::zima {
    struct ZIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"-N9yA9EWP7d7C40R                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZIMA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZIM         ")))), trim_right(b"Invader ZIM                     "), trim_right(x"20546865206d6f7374206570696320626c6f636b636861696e20696e766173696f6e20697320636f6d696e6720210d0a0d0a47657420726561647920666f7220245a494d20746f20636f6e7175657220746865206469676974616c2067616c6178792e200d0a4f6e6c792074686520666173746573742077696c6c206a6f696e20746865206c6567696f6e2041726520796f7520726561647920746f2062652070617274206f6620746865206368616f733f20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIMA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIMA>>(v4);
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

