module 0x2c0064dea4ea7861fa185ab2ca90405f88af8083ac611197b42a05432a9c19b3::cat_theme {
    struct CAT_THEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT_THEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT_THEME>(arg0, 9, b"CAT_THEME", b"GCat", b"Cat Thene MemeCoin Built On Sui Network. Specially Designed At Wewe Pump . ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ac39083-14bb-4c11-95f7-82291d1d3a22.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT_THEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT_THEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

