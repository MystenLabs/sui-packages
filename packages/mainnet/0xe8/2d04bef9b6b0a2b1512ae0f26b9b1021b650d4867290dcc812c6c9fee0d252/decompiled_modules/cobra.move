module 0xe82d04bef9b6b0a2b1512ae0f26b9b1021b650d4867290dcc812c6c9fee0d252::cobra {
    struct COBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBRA>(arg0, 9, b"COBRA", b"CobraFi", b"Pump first, Pump hard, No mercy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1d3808a-8d77-4eb4-9b09-7736470c0fb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COBRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

