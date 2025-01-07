module 0xa1ecd1afcbe30a9841c919f0c7ee5aa622bc8e5357722749afac6293b19449ae::hippou {
    struct HIPPOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOU>(arg0, 9, b"HIPPOU", b"HIPPOU INU", b"Yes or no ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d715f261-987d-469b-9ce5-362d529695a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

