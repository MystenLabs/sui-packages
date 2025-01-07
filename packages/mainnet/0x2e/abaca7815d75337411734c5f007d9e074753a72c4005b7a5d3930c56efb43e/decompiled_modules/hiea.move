module 0x2eabaca7815d75337411734c5f007d9e074753a72c4005b7a5d3930c56efb43e::hiea {
    struct HIEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIEA>(arg0, 9, b"HIEA", b"hiheha", b"NIVIA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb63b6eb-f5ae-496b-bbd7-3f72b8e5225d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

