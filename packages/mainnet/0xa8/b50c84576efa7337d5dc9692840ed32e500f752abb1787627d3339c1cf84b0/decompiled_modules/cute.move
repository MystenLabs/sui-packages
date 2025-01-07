module 0xa8b50c84576efa7337d5dc9692840ed32e500f752abb1787627d3339c1cf84b0::cute {
    struct CUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTE>(arg0, 9, b"CUTE", b"Light", b"Light color", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab3ac926-490f-4242-a735-479565d8a667.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

