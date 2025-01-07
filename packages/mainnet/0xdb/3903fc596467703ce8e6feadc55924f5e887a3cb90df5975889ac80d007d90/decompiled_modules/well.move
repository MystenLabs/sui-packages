module 0xdb3903fc596467703ce8e6feadc55924f5e887a3cb90df5975889ac80d007d90::well {
    struct WELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WELL>(arg0, 9, b"WELL", b"Well Done", b"Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44f359d0-c7b4-4127-8d1b-2b87c7e41c41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

