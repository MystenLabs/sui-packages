module 0xf8e8d1dbf93633d90553873d74eea3023e33ddf3801829ee6a6b3ba58c5f61f0::mews {
    struct MEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWS>(arg0, 9, b"MEWS", b"MewSui", b"orginal mew on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2347d2e-9fbe-4541-955d-9c44019a02c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

