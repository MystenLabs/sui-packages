module 0x9aaf1b824d5fcd53ca8663ef5d7073f8675169d63188c43bebbe009de4104bba::wedogs {
    struct WEDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOGS>(arg0, 9, b"WEDOGS", b"Dog's", b"Lets do fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c3bdded-a717-4c4c-81d5-9c8b077c66ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

