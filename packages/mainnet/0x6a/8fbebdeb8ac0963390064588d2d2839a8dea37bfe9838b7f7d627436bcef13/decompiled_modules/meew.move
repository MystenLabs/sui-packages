module 0x6a8fbebdeb8ac0963390064588d2d2839a8dea37bfe9838b7f7d627436bcef13::meew {
    struct MEEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEW>(arg0, 9, b"MEEW", b"Meew", b"Meew in countryhouse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03092644-d524-44c7-ab32-3b8c3d544a0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

