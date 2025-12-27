module 0xd3908cd33ecb934c1c141d12d50cc398026cafc215f3de3a314caff0859a01bb::usd1 {
    struct USD1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/ItxrUDdfDdkZf8Cw-MwJtVEgY3OJqEab0DEZInxPoNo";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/ItxrUDdfDdkZf8Cw-MwJtVEgY3OJqEab0DEZInxPoNo"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USD1>(arg0, 9, trim_right(b"USD1"), trim_right(b"WorId Llberty Flnanclai USD"), trim_right(b"USD1 is a fiat-backed digital asset, designed to maintain a 1:1 equivalence with the U.S. dollar."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USD1>>(0x2::coin::mint<USD1>(&mut v5, 1000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD1>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USD1>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USD1>>(v4);
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

