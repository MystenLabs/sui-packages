module 0xf15efc9bcea1275c6c168ba7ace1f12212e4bc302854d5d690e839d15fcac0e9::joker9 {
    struct JOKER9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER9>(arg0, 9, b"JOKER9", b"A joke", b"How much are you willing to pay to laugh HA Ha Ha Ha Ha Ha Ha Ha Ha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3be952c-bd00-4749-867f-0fca3dae7af9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKER9>>(v1);
    }

    // decompiled from Move bytecode v6
}

