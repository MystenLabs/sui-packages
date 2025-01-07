module 0xc2fe4cdab8496f5b668604c47e42b34a567dccde7344832093e392298b4add51::speo {
    struct SPEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEO>(arg0, 9, b"SPEO", b"SPeo", b"Peo on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f94e2452-03ee-4524-b57b-2e6180c3330c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

