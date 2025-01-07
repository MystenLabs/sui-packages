module 0xeedb34b0a8b87bcaddbc15aafe497eee505783ff74a058587d125e408b1bad29::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 9, b"GOKU", b"SAIYAN", b"Saiyans are a powerful and warlike race in the Dragon Ball series, known for their incredible strength and ability to become even stronger after recovering from near-death experiences. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15ee01e2-4e1f-4b3a-9656-7f521662aa31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

