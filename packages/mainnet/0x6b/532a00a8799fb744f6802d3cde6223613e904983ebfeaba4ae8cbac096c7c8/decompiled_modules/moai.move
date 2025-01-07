module 0x6b532a00a8799fb744f6802d3cde6223613e904983ebfeaba4ae8cbac096c7c8::moai {
    struct MOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOAI>(arg0, 0, b"MOAI", b"MOAI", b"Utility token of the Stashdrop ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://stashdrop.org/assets/tokens/moai.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOAI>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOAI>>(v2, @0xd27cc4a3a53b74e3abebb100949839d37d21264ad7616f7653019803fc43a046);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

