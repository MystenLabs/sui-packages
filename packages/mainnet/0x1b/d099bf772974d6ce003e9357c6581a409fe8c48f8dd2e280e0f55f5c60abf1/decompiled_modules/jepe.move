module 0x1bd099bf772974d6ce003e9357c6581a409fe8c48f8dd2e280e0f55f5c60abf1::jepe {
    struct JEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEPE>(arg0, 6, b"JEPE", b"Jepe", b"the most memeable jellyfish on the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731163424794.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

