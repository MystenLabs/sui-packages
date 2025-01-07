module 0x4dc48771c63eb5936d84e60a1277e9f903d3edcd4f742f383950b81c09a366da::pokko {
    struct POKKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKKO>(arg0, 9, b"POKKO", b"MamyPokko", b"The best Brand diapers in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1e1d061-bf06-4c52-ac8b-51b7f11e8865.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

