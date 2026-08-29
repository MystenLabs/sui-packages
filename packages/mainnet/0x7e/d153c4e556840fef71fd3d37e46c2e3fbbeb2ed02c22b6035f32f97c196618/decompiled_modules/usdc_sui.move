module 0x7ed153c4e556840fef71fd3d37e46c2e3fbbeb2ed02c22b6035f32f97c196618::usdc_sui {
    struct USDC_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC_SUI>(arg0, 9, b"USDC-SUI", b"Te USD", b"TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploader.irys.xyz/FgENZKtuQEyxUhH6JoyjJB64QbvT6Go1HgiqYrPenBy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDC_SUI>(&mut v2, 3680000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC_SUI>>(v2, @0x3f3bfd7e6ab7311b7c8d3e112f4c424148024f547235ca7fabee1212798849f5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

