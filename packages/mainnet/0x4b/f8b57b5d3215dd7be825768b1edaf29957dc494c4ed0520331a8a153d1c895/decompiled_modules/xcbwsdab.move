module 0x4bf8b57b5d3215dd7be825768b1edaf29957dc494c4ed0520331a8a153d1c895::xcbwsdab {
    struct XCBWSDAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCBWSDAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCBWSDAB>(arg0, 9, b"XCBWSDAB", b"AFGSSGBD", b"SADF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a292dd8-8f5d-44b4-8d0d-1e5499d6f1c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCBWSDAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XCBWSDAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

