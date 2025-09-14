module 0x62b9ff5fd6570abea65cb920b7126f310e80b84382ab462c13996be3578d6aa::kat {
    struct KAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"63569178bf53b772c8d16a216601eb0a7400adcd52c68d8ad04d39eeba9c4356                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KAT         ")))), trim_right(b"KAT                             "), trim_right(x"244b41542069736e74206a7573742061206d656d65636f696e2020686573206120666561726c657373206361742063686173696e672070756d707320616e6420636c6177696e67207468726f75676820726573697374616e63652e204576657279206a756d702074616b65732068696d20636c6f73657220746f204154482c20616e642065766572792070757272206272696e6773206672657368206c69717569646974792e0a0a4e6f7720244b415420696e766974657320796f7520746f206a6f696e206869732070726964652e20496e207468697320636f6d6d756e6974792c2063616e646c6573206172652066756e2c206d656d6573206172652073747261746567792c20616e6420657665727920686f6c6465722069732070617274206f6620746865206c6567656e642e2020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAT>>(v4);
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

