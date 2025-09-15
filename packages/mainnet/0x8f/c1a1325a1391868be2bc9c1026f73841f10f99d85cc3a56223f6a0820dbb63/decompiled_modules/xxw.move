module 0x8fc1a1325a1391868be2bc9c1026f73841f10f99d85cc3a56223f6a0820dbb63::xxw {
    struct XXW has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/7US3W7iIvpEcn4x-NJOY65z_OCRxZvETgOriRzVEZOs";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/7US3W7iIvpEcn4x-NJOY65z_OCRxZvETgOriRzVEZOs"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<XXW>(arg0, 9, trim_right(b"xxw"), trim_right(b"xxw  "), trim_right(b"225"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXW>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XXW>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXW>>(v4);
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

