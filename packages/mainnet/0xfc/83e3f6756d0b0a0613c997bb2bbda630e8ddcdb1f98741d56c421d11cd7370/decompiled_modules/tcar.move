module 0xfc83e3f6756d0b0a0613c997bb2bbda630e8ddcdb1f98741d56c421d11cd7370::tcar {
    struct TCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCAR>(arg0, 9, b"TCAR", b"CAT", x"497420646570696374732074686520706c617966756c206e6174757265206f6620636174732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c4df7d6-d889-4993-9a4e-5751ae90743a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

