module 0x5249b2c9a94862c248799e01ed10514d41ed71b3177748da5e838c0b14f3ce27::sidra {
    struct SIDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDRA>(arg0, 9, b"SIDRA", b"Sidra coin", b"Personal digital currency ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54075ab3-2e6a-42e3-823b-e302c1adc740.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIDRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

