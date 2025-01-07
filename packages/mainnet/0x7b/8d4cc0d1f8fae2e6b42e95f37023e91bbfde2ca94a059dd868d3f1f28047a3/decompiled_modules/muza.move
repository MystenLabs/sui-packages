module 0x7b8d4cc0d1f8fae2e6b42e95f37023e91bbfde2ca94a059dd868d3f1f28047a3::muza {
    struct MUZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUZA>(arg0, 9, b"MUZA", b"Muzaratti", b"A unique name comes from nowhere ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65840c10-f233-4723-bb77-ade36c807095.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

