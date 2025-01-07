module 0xc4690fea14fe3596893fc52d651f03124421b29e855f2af557303e9fb7cabf56::suitoken {
    struct SUITOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOKEN>(arg0, 9, b"SUITOKEN", b"Supsup", b"Suimeme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7fb68ce-5556-4d3d-aa61-f3cadcee684c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

