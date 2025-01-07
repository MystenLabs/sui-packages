module 0xe8263c789382c3e63235a3961c994c8f0fc8910387175eb6918307019ecfe707::moondeng {
    struct MOONDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDENG>(arg0, 9, b"MOONDENG", b"Moon Deng", b"Moo Deng On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fade6f66-a58f-48e9-b868-2398e4ca9133.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

