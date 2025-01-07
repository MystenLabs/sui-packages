module 0xc0214f30aed7a56fc706036763e64afb84fc1c8f6d1c25fe4dd98a7eceb936cb::kwndn {
    struct KWNDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWNDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWNDN>(arg0, 9, b"KWNDN", b"hajsn", b"bebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52113982-7af0-44a6-b121-65a2dac9ab75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWNDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWNDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

