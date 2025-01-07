module 0xc31f0f745e90ba2618519193f3a6b55fa7063b51cfa1ad8013059881b3220571::das {
    struct DAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAS>(arg0, 9, b"DAS", b"Daddy ", b"Every dad is an hero ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cd496bc-9415-47a1-bf5c-8e7a536a6149.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

