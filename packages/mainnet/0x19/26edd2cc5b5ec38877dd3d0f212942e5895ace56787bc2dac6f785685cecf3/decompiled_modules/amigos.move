module 0x1926edd2cc5b5ec38877dd3d0f212942e5895ace56787bc2dac6f785685cecf3::amigos {
    struct AMIGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMIGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMIGOS>(arg0, 6, b"AMIGOS", b"Amigos coin", x"284c61756e6368696e6720736f6f6e206f6e20547572626f7329205468652023416d69676f73206d656d6520636f696e206f6e2023537569200a237375696d656d6520237375696d656d65636f696e2023616d69676f73636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731021897011.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMIGOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMIGOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

