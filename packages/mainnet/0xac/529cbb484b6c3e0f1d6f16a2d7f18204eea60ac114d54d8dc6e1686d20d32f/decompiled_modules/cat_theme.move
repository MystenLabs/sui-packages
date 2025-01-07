module 0xac529cbb484b6c3e0f1d6f16a2d7f18204eea60ac114d54d8dc6e1686d20d32f::cat_theme {
    struct CAT_THEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT_THEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT_THEME>(arg0, 9, b"CAT_THEME", b"GCat", b"Cat Thene MemeCoin Built On Sui Network. Specially Designed At Wewe Pump . ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/325021c9-f2b8-4301-9252-d630bc8200ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT_THEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT_THEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

