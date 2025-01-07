module 0x7f3b6e41b884f36351ba0aa6b9027961c4c90aac85d51ee8531c83b8cbe32d35::duduck {
    struct DUDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDUCK>(arg0, 9, b"DUDUCK", b"DuckyDuck", b"Tiken for someone have a duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8c6aad5-e00c-4ce5-a8ce-fad4a3b06235.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

