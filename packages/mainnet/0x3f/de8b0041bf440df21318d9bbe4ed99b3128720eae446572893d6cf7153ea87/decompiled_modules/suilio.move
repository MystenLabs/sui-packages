module 0x3fde8b0041bf440df21318d9bbe4ed99b3128720eae446572893d6cf7153ea87::suilio {
    struct SUILIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIO>(arg0, 9, b"SUILIO", b"Suilio", b", a young lion from a wealthy family, squandered his inheritance due to an extravagant lifestyle and poor financial choices.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6fa946d-66cc-4061-973c-b758408d3cdc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

