module 0x5c3d6cc846db041a8c417e0fe5f5a23274f50420c17305830f01ef7caf2c3a1c::imeme {
    struct IMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMEME>(arg0, 9, b"IMEME", b"Inv Meme", b"Inspired from inverting a meme to create an entirely new token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/787fd59e-a5ae-41c1-a6a5-ac99779a26a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

