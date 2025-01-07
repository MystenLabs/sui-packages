module 0x4f38cf265b8bd4e588c96472ecbe355e36fd7c78df8b4d1d3355311eed4b25bf::buchinight {
    struct BUCHINIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCHINIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCHINIGHT>(arg0, 9, b"BUCHINIGHT", b"Buchi", b"Sleep sexy to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36f49bec-7796-4c7c-b3ef-fb53d5d2fa28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCHINIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCHINIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

