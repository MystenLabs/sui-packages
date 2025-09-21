module 0x6672fcdc0e7fe965ea25602b42c08b0ac5586fc0702688a90c80d15d35e61428::xxo {
    struct XXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/wi2OEjHnO9DxaYtVoGF2UfT2qbc4p6r5wCxDOf3IHnY";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/wi2OEjHnO9DxaYtVoGF2UfT2qbc4p6r5wCxDOf3IHnY"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<XXO>(arg0, 9, trim_right(b"XXO"), trim_right(b"xx"), trim_right(b"good"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXO>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XXO>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXO>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

