module 0x678ae191c2068da80260d9c53e83b6cc55ca0e7f12fa11b8d0235eda91de4bb0::wolverine {
    struct WOLVERINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLVERINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLVERINE>(arg0, 9, b"WOLVERINE", b"wolverine", b"Logan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c25ad7e-423b-41b0-bf9b-c54a03b9c8be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLVERINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOLVERINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

