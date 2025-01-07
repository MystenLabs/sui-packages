module 0x4b23858c473a9351aee93cf0fb291eb91d3efcdfdfb5bfb918bfbed00a02a6ac::jerry_coin {
    struct JERRY_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JERRY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERRY_COIN>(arg0, 9, b"JERRY_COIN", b"Jerry", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f28633c-728f-426d-95f1-e3ed8edd7089.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERRY_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JERRY_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

