module 0xef020b140e1facb47d9aa2c535182c37fac9d144cfd156b9d47384852afd31d5::superman {
    struct SUPERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERMAN>(arg0, 9, b"SUPERMAN", b"S", b"Superman ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b44b2bf9-e732-4026-8647-77547483b079.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

