module 0x249934f377b2fc72bfca6a09c3a170ff84a0e24813e4bd72e953a55aba7165fb::suika {
    struct SUIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKA>(arg0, 6, b"SUIKA", b"Sui Kachu", x"5355494b4143485520746865207765747465737420636f696e206f6e2053554921205768617420646f20796f7520676574207768656e20796f75206d697820776174657220616e6420656c6563747269636974792c205355494b41434855210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7980451_89607c1e2b_a8a9e2fe36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

